import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const Sidebar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  try {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!mounted) return; // ✅ avoid setState if widget is disposed

    if (doc.exists) {
      setState(() {
        userName = doc.data()?['name'] ?? 'Student';
      });
    }
  } catch (e) {
    if (mounted) {
      setState(() {
        userName = 'Student';
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
if (uid == null) {
  return const SizedBox(); // return empty widget if logged out
}
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.add_circle_outline, 'label': 'Submit Grievance'},
      {'icon': Icons.list_alt, 'label': 'My Grievances'},
      {'icon': Icons.notifications, 'label': 'Notices'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Container(
      width: 220,
      color: const Color(0xFF0052CC),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/profile_man.png'),
          ),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ...List.generate(menuItems.length, (index) {
            final item = menuItems[index];
            final isSelected = index == widget.selectedIndex;
            return ListTile(
              leading: Icon(item['icon'], color: Colors.white),
              title: Text(
                item['label'],
                style: TextStyle(
                  color: isSelected ? Colors.yellowAccent : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onTap: () => widget.onItemSelected(index),
            );
          }),
        ],
      ),
    );
  }
}
