import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash1.dart';
import 'splash2.dart';
import 'login.dart';
import 'signup.dart';
import 'welcome.dart';
import 'dashboard.dart';
import 'dashboard2.dart';
import 'settings.dart';
import 'edit_profile.dart';
import 'create_note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Replace with your Supabase project credentials
  // Get these from your Supabase project settings -> API
  // Project URL: Settings -> API -> Project URL
  // anon key: Settings -> API -> Project API keys -> anon/public
  await Supabase.initialize(
    url: 'https://xmjqbwnpeawcxgqtwhfv.supabase.co',  // Example: 'https://xxxxxxxxxxxx.supabase.co'
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtanFid25wZWF3Y3hncXR3aGZ2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0ODI2NzA5NCwiZXhwIjoyMDYzODQzMDk0fQ.Ru9ZhPpVU-WY9QzFN_1FRK0dWaqlI_edQa_BI-szzgo', // Example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6...'
  );

  // --- Kode Tes Koneksi Supabase ---
  // try {
  //   // Coba ganti 'nama_tabel_anda' dengan nama tabel yang ada di Supabase Anda.
  //   // Jika belum ada tabel, ini akan menghasilkan error "relation not found",
  //   // yang menandakan Supabase berhasil dihubungi.
  //   final response = await Supabase.instance.client
  //       .from('users') // GANTI INI JIKA PERLU
  //       .select()
  //       .limit(1);

  //   // Jika menggunakan supabase_flutter >= 2.0.0, error akan dilempar jika gagal.
  //   // 'response' akan berupa List<Map<String, dynamic>> jika berhasil.
  //   print(
  //       'connection success, data received although table is empty. Respons: $response');
  // } catch (e) {
  //   print(
  //       'connection failed, table not found. Error: $e');
  // }
  // --- Akhir Kode Tes Koneksi Supabase ---

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash1(), // First screen
        '/splash2': (context) => const Splash2(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUp(),
        '/dashboard': (context) => const Dashboard(),
        '/dashboard2': (context) => const Dashboard2(),
        '/settings': (context) => const SettingsScreen(),
        '/notes': (context) => const CreateNoteScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
      },
    );
  }
}
