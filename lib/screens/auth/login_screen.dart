// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _loading = false;
  bool _showPass = false;
  String _error = '';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );

      if (response.user == null) {
        setState(() => _error = 'Login gagal. Periksa email dan password.');
        return;
      }

      // Update last_login di tabel pegawai
      await _supabase
          .from('pegawai')
          .update({'last_login': DateTime.now().toIso8601String()}).eq(
              'auth_user_id', response.user!.id);
    } on AuthException catch (e) {
      setState(() => _error = _pesanError(e.message));
    } catch (e) {
      setState(() => _error = 'Terjadi kesalahan. Coba lagi.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _pesanError(String msg) {
    if (msg.contains('Invalid login credentials')) {
      return 'Email atau password salah.';
    }
    if (msg.contains('Email not confirmed')) {
      return 'Email belum dikonfirmasi. Cek inbox kamu.';
    }
    if (msg.contains('Too many requests')) {
      return 'Terlalu banyak percobaan. Tunggu beberapa menit.';
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Panel kiri — branding
              Container(
                width: 420,
                height: 520,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A3A6B),
                      Color(0xFF0D6EFD),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Row(children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.account_balance,
                            color: Colors.white, size: 28),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('KERJA.in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1)),
                          Text('Sistem Manajemen Kerja',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 12)),
                        ],
                      ),
                    ]),
                    SizedBox(height: 48),

                    Text(
                        'Kelola Surat,\nKegiatan & Anggaran\ndalam Satu Platform.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.4)),
                    SizedBox(height: 20),

                    Text(
                        'Dirancang khusus untuk Sub-BLUD\nBiro Perekonomian Setda Prov. Jawa Timur.',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 13,
                            height: 1.6)),
                    SizedBox(height: 40),

                    // Feature chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _chip(Icons.email_outlined, 'Persuratan'),
                        _chip(Icons.calendar_month_outlined, 'Kegiatan'),
                        _chip(Icons.receipt_long_outlined, 'SPJ'),
                        _chip(Icons.bar_chart_outlined, 'Monitoring'),
                      ],
                    ),
                  ],
                ),
              ),

              // Panel kanan — form login
              Container(
                width: 380,
                height: 520,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Masuk ke Sistem',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6),
                    Text('Gunakan akun yang telah didaftarkan admin.',
                        style: TextStyle(fontSize: 13, color: Colors.grey)),
                    SizedBox(height: 32),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => v!.isEmpty
                                ? 'Email wajib diisi'
                                : !v.contains('@')
                                    ? 'Format email tidak valid'
                                    : null,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'nama@jatimprov.go.id',
                              prefixIcon: Icon(Icons.email_outlined, size: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF0D6EFD), width: 2)),
                            ),
                          ),
                          SizedBox(height: 16),

                          // Password
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: !_showPass,
                            validator: (v) =>
                                v!.isEmpty ? 'Password wajib diisi' : null,
                            onFieldSubmitted: (_) => _login(),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline, size: 20),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _showPass = !_showPass),
                                icon: Icon(
                                  _showPass
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF0D6EFD), width: 2)),
                            ),
                          ),
                          SizedBox(height: 8),

                          // Error message
                          if (_error.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.08),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.red.withOpacity(.3)),
                              ),
                              child: Row(children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(_error,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red)),
                                ),
                              ]),
                            ),

                          SizedBox(height: 24),

                          // Tombol login
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0D6EFD),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              child: _loading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white))
                                  : Text('Masuk',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),
                    Divider(color: Colors.grey.shade200),
                    SizedBox(height: 16),

                    // Info admin
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Belum punya akun? Hubungi administrator sistem untuk pendaftaran.',
                            style: TextStyle(fontSize: 11, color: Colors.blue),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: Colors.white),
        SizedBox(width: 5),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
