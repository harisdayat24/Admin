// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class UploadDokumenWidget extends StatefulWidget {
  final String? existingUrl;
  final String folder;
  final String label;
  final Function(String url) onUploaded;
  final VoidCallback? onDeleted;

  const UploadDokumenWidget({
    super.key,
    this.existingUrl,
    required this.folder,
    this.label = 'Upload Dokumen',
    required this.onUploaded,
    this.onDeleted,
  });

  @override
  State<UploadDokumenWidget> createState() => _UploadDokumenWidgetState();
}

class _UploadDokumenWidgetState extends State<UploadDokumenWidget> {
  final _supabase = Supabase.instance.client;
  static const _bucket = 'surat';

  bool _uploading = false;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.existingUrl;
  }

  @override
  void didUpdateWidget(UploadDokumenWidget old) {
    super.didUpdateWidget(old);
    if (old.existingUrl != widget.existingUrl) {
      setState(() => _currentUrl = widget.existingUrl);
    }
  }

  Future<void> _pickAndUpload() async {
    setState(() => _uploading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      PlatformFile file = result.files.first;
      Uint8List? bytes = file.bytes;
      if (bytes == null) return;

      if (bytes.lengthInBytes > 10 * 1024 * 1024) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('❌ File terlalu besar. Maksimal 10MB.'),
            backgroundColor: Colors.red,
          ));
        }
        return;
      }

      if (_currentUrl != null && _currentUrl!.isNotEmpty) {
        await _deleteFile(_currentUrl!);
      }

      String ext = file.extension ?? 'pdf';
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = '${widget.folder}/${timestamp}_${file.name}';

      await _supabase.storage.from(_bucket).uploadBinary(
            fileName,
            bytes,
            fileOptions: FileOptions(contentType: _mimeType(ext), upsert: true),
          );

      String url = _supabase.storage.from(_bucket).getPublicUrl(fileName);
      setState(() => _currentUrl = url);
      widget.onUploaded(url);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('✅ Dokumen berhasil diupload'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('❌ Gagal upload: $e'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _deleteFile(String url) async {
    try {
      Uri uri = Uri.parse(url);
      String path =
          uri.pathSegments.skipWhile((s) => s != _bucket).skip(1).join('/');
      await _supabase.storage.from(_bucket).remove([path]);
    } catch (_) {}
  }

  Future<void> _konfirmasiHapus() async {
    bool? konfirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Hapus Dokumen?'),
        content: Text('Dokumen akan dihapus permanen dari storage.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirm == true && _currentUrl != null) {
      await _deleteFile(_currentUrl!);
      setState(() => _currentUrl = null);
      widget.onDeleted?.call();
    }
  }

  Future<void> _bukaUrl(String url) async {
    print('=== BUKA URL ===');
    print(url);
    html.window.open(url, '_blank');
  }

  String _mimeType(String ext) {
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

  String _namaFile(String url) {
    try {
      String last = Uri.parse(url).pathSegments.last;
      int idx = last.indexOf('_');
      return idx >= 0 ? last.substring(idx + 1) : last;
    } catch (_) {
      return 'Dokumen';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUrl != null && _currentUrl!.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withOpacity(.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                _namaFile(_currentUrl!),
                style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () => _bukaUrl(_currentUrl!),
              icon: Icon(Icons.open_in_new, size: 18, color: Colors.blue),
              tooltip: 'Buka Dokumen',
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            SizedBox(width: 4),
            IconButton(
              onPressed: _uploading ? null : _pickAndUpload,
              icon: _uploading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Icon(Icons.upload_outlined, size: 18, color: Colors.orange),
              tooltip: 'Ganti Dokumen',
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            SizedBox(width: 4),
            IconButton(
              onPressed: _konfirmasiHapus,
              icon: Icon(Icons.delete_outline, size: 18, color: Colors.red),
              tooltip: 'Hapus Dokumen',
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: _uploading ? null : _pickAndUpload,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _uploading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Color(0xFF0D6EFD)))
                : Icon(Icons.upload_file_outlined,
                    size: 18, color: Color(0xFF0D6EFD)),
            SizedBox(width: 8),
            Text(
              _uploading ? 'Mengupload...' : widget.label,
              style: TextStyle(
                fontSize: 13,
                color: _uploading ? Colors.grey : Color(0xFF0D6EFD),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Text('PDF / JPG / PNG  •  max 10MB',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
