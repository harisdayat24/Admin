import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:minia_web_project/screens/auth/login_screen.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Listen perubahan auth state
    _supabase.auth.onAuthStateChange.listen((data) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = _supabase.auth.currentSession;

    if (session != null) {
      return SideBarPage(); // Sudah login → tampilkan app
    } else {
      return LoginScreen(); // Belum login → tampilkan login
    }
  }
}
