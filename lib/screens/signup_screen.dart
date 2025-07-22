import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_grivence_portal/layout/mobile_layout.dart';
import 'package:student_grivence_portal/layout/responsive_layout.dart';
import 'package:student_grivence_portal/layout/web_layout.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _loading = false;

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      // Save name in Firestore
      await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
        'name': _name.text.trim(),
        'email': _email.text.trim(),
      });

      Fluttertoast.showToast(msg: 'Signup Successful!');
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (_) => const ResponsiveLayout(
            mobileLayout: MobileLayout(),
            webLayout: WebLayout(),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Signup failed");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
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
                  'Create Your Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (val) =>
                      val == null || !val.contains('@') ? 'Enter valid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (val) =>
                      val == null || val.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _loading ? null : _signup,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
