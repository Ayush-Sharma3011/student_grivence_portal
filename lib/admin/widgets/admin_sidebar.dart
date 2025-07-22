import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const AdminSidebar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.list_alt, 'label': 'Manage Grievances'},
      {'icon': Icons.people, 'label': 'Users'},
    ];

    return Container(
      width: 220,
      color: const Color(0xFF001C55),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/profile_man.png'), // Add your admin avatar
          ),
          const SizedBox(height: 12),
          const Text(
            "Admin Panel",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ...List.generate(menuItems.length, (index) {
            final item = menuItems[index];
            final isSelected = index == selectedIndex;
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
              onTap: () => onItemSelected(index),
            );
          }),
        ],
      ),
    );
  }
}
