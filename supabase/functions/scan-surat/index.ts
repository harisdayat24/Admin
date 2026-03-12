import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

function parseGeminiResponse(raw: string): Record<string, any> {
  let cleaned = raw.trim();
  if (cleaned.startsWith('```')) {
    cleaned = cleaned.replace(/^```(?:json)?\s*\n?/, '').replace(/\n?```\s*$/, '');
  }
  return JSON.parse(cleaned);
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const payload = await req.json();
    console.log("=== PAYLOAD KEYS ===", Object.keys(payload));
console.log("=== PAYLOAD ===", JSON.stringify(payload).substring(0, 200));
    
    // Prioritas: base64 langsung dari Flutter, fallback ke URL
    let base64String = payload.pdfBase64 || null;

    if (!base64String) {
      const file_url = payload.file_url || payload.imageUrl;
      if (!file_url) throw new Error("Tidak ada data PDF.");

      console.log("=== Fetching PDF from URL ===");
      const pdfResponse = await fetch(file_url);
      if (!pdfResponse.ok) throw new Error(`Gagal fetch PDF: ${pdfResponse.status}`);
      
      const pdfBytes = new Uint8Array(await pdfResponse.arrayBuffer());
      // Manual base64
      const lookup = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
      const parts: string[] = [];
      for (let i = 0; i < pdfBytes.length; i += 3) {
        const a = pdfBytes[i];
        const b = i + 1 < pdfBytes.length ? pdfBytes[i + 1] : 0;
        const c = i + 2 < pdfBytes.length ? pdfBytes[i + 2] : 0;
        parts.push(
          lookup[a >> 2] +
          lookup[((a & 3) << 4) | (b >> 4)] +
          (i + 1 < pdfBytes.length ? lookup[((b & 15) << 2) | (c >> 6)] : '=') +
          (i + 2 < pdfBytes.length ? lookup[c & 63] : '=')
        );
      }
      base64String = parts.join('');
    }

    console.log("=== Base64 ready, length:", base64String.length, "===");

    const apiKey = Deno.env.get('GEMINI_API_KEY');
    if (!apiKey) throw new Error("API Key Gemini belum diatur.");

    const prompt = `Ekstrak informasi dari dokumen surat resmi berikut.
Kembalikan HANYA dalam format JSON dengan key PERSIS seperti ini:
{
  "no_surat": "Nomor surat lengkap",
  "tgl": "Tanggal surat dalam format YYYY-MM-DD",
  "hal": "Hal atau perihal surat",
  "asal": "Nama instansi pengirim surat",
  "jenis": "MASUK atau KELUAR (tentukan dari konteks: jika ini surat yang dikirim oleh instansi lain, maka MASUK. Jika surat dari Biro Perekonomian Setda Jatim ke pihak lain, maka KELUAR)"
}
Jika ada informasi yang tidak ditemukan, isi valuenya dengan null.
Untuk tanggal, WAJIB konversi ke format YYYY-MM-DD.`;

    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`;

    // Bangun body manual — hindari JSON.stringify pada objek besar
    const requestBody = '{"contents":[{"parts":[{"text":' +
      JSON.stringify(prompt) +
      '},{"inlineData":{"mimeType":"application/pdf","data":"' +
      base64String +
      '"}}]}],"generationConfig":{"responseMimeType":"application/json"}}';

    console.log("=== Sending to Gemini, body length:", requestBody.length, "===");

    const geminiResponse = await fetch(geminiUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: requestBody,
    });

    const geminiData = await geminiResponse.json();

    if (!geminiResponse.ok) {
      throw new Error(geminiData.error?.message || "Gagal dari Gemini");
    }

    if (!geminiData.candidates || geminiData.candidates.length === 0) {
      throw new Error("Gemini response kosong.");
    }

    const candidate = geminiData.candidates[0];
    if (candidate.finishReason && candidate.finishReason !== 'STOP') {
      throw new Error(`Gemini berhenti: ${candidate.finishReason}`);
    }

    const responseText = candidate.content?.parts?.[0]?.text;
    if (!responseText) throw new Error("Response Gemini kosong.");

    const parsed = parseGeminiResponse(responseText);

    const normalized = {
      no_surat: parsed.no_surat ?? null,
      tgl: parsed.tgl ?? null,
      hal: parsed.hal ?? null,
      asal: parsed.asal ?? null,
      jenis: parsed.jenis ?? "MASUK",
    };

    return new Response(JSON.stringify(normalized), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    });

  } catch (error) {
    console.error("=== ERROR ===", error.message);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    });
  }
});