import 'package:flutter/material.dart';
import 'package:minia_web_project/screens/auth/auth_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await sb.Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseKey,
  );

  runApp(const ProviderScope(child: KerjaApp()));
}

class KerjaApp extends StatelessWidget {
  const KerjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D6EFD),
        ),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
    );
  }
}
