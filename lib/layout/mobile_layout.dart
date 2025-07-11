import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int selectedIndex = 0;

  void handleNavigation(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const Center(child: Text('Submit Grievance (Coming Soon)'));
      case 2:
        return const Center(child: Text('My Grievances (Coming Soon)'));
      case 3:
        return const Center(child: Text('Notices (Coming Soon)'));
      case 4:
        return const Center(child: Text('Settings (Coming Soon)'));
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grievance Portal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0052CC)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
                  SizedBox(height: 8),
                  Text('Avantika Rana',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
            _buildDrawerItem(Icons.add_circle_outline, 'Submit Grievance', 1),
            _buildDrawerItem(Icons.list_alt, 'My Grievances', 2),
            _buildDrawerItem(Icons.notifications, 'Notices', 3),
            _buildDrawerItem(Icons.settings, 'Settings', 4),
          ],
        ),
      ),
      body: _getSelectedScreen(),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedIndex == index,
      onTap: () {
        Navigator.pop(context); // Close the drawer
        handleNavigation(index);
      },
    );
  }
}
