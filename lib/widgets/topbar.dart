import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.loadingUser, required this.userName});

  final String? userName;
  final bool loadingUser;

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TopBarState extends State<TopBar> {
  late String? _userName;
  late bool _loadingUser;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _loadingUser = widget.loadingUser;
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (!mounted) return;

      setState(() {
        _userName = doc.data()?['name'] ?? 'User';
        _loadingUser = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _userName = 'User';
          _loadingUser = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _loadingUser ? 'Loading...' : '👋 Hello, ${_userName ?? "User"}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Log out"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true) {
                    await FirebaseAuth.instance.signOut();

                    if (!mounted) return;

                    Navigator.of(context)
                        .pushReplacementNamed('/login'); // Go to login
                  }
                },
                icon: const Icon(Icons.logout, size: 16),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052CC),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
