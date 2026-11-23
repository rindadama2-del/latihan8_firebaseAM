import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi Firebase
  // Inisialisasi Firebase menggunakan opsi yang di-generate sesuai platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Simple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Menggunakan StreamBuilder untuk mendeteksi status login
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Menampilkan loading saat mengecek status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Jika terdapat data user (sudah login), tampilkan halaman info
        if (snapshot.hasData) {
          return UserInfoScreen(user: snapshot.data!);
        }
        // Jika tidak ada data user, tampilkan halaman login
        return const LoginScreen();
      },
    );
  }
}