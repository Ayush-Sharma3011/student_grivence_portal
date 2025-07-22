import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_grivence_portal/screens/dashboard_screen.dart';
import 'package:student_grivence_portal/screens/login_screen.dart';
import 'package:student_grivence_portal/screens/welcome_screen.dart';
import 'package:student_grivence_portal/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const GrievancePortalApp());
}

class GrievancePortalApp extends StatelessWidget {
  const GrievancePortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Grievance Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: WelcomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        
      },
      
    );
    
  }
}
