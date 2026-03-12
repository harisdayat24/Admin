import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static final _supabase = Supabase.instance.client;
  static const _bucket = 'dokumen-kerja';

  /// Pilih file dan upload ke Supabase Storage
  /// [folder] contoh: 'surat', 'kegiatan', 'spj'
  /// Returns public URL atau null jika dibatalkan
  static Future<String?> pickAndUpload({
    required String folder,
    List<String> allowedExtensions = const ['pdf', 'jpg', 'jpeg', 'png'],
  }) async {
    // Pilih file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      withData: true, // Wajib true untuk Flutter Web
    );

    if (result == null || result.files.isEmpty) return null;

    PlatformFile file = result.files.first;
    Uint8List? bytes = file.bytes;
    if (bytes == null) return null;

    // Generate nama unik
    String ext = file.extension ?? 'pdf';
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = '$folder/${timestamp}_${file.name}';

    // Upload ke Supabase Storage
    await _supabase.storage.from(_bucket).uploadBinary(
          fileName,
          bytes,
          fileOptions: FileOptions(
            contentType: _mimeType(ext),
            upsert: true,
          ),
        );

    // Ambil public URL
    String url = _supabase.storage.from(_bucket).getPublicUrl(fileName);
    return url;
  }

  /// Hapus file dari storage berdasarkan URL
  static Future<void> deleteByUrl(String url) async {
    try {
      // Extract path dari URL
      Uri uri = Uri.parse(url);
      String path =
          uri.pathSegments.skipWhile((s) => s != _bucket).skip(1).join('/');
      await _supabase.storage.from(_bucket).remove([path]);
    } catch (_) {}
  }

  static String _mimeType(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return 'application/octet-stream';
    }
  }
}
