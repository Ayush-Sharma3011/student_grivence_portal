import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_grivence_portal/admin/admin_layout.dart';
import '../layout/responsive_layout.dart';
import '../layout/web_layout.dart';
import '../layout/mobile_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _login() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _loading = true);
  try {
    // Sign in the user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // ✅ Check if user is admin
    final isAdmin = await isAdminUser();

    Fluttertoast.showToast(msg: 'Login Successful');

    // 🔁 Navigate accordingly
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isAdmin
            ? const AdminLayout() // ⬅️ Create this screen
            : const ResponsiveLayout(
                mobileLayout: MobileLayout(),
                webLayout: WebLayout(),
              ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.message ?? "Login failed");
  } finally {
    setState(() => _loading = false);
  }
}

  Future<bool> isAdminUser() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return false;

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return doc.exists && doc.data()?['role'] == 'admin';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              shrinkWrap: true,
              children: [
                const Text(
                  'Welcome Back 👋',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (val) => val == null || !val.contains('@')
                      ? 'Enter valid email'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (val) =>
                      val == null || val.length < 6 ? 'Min 6 chars' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF0052CC),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
