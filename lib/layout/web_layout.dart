import 'package:flutter/material.dart';
import 'package:student_grivence_portal/screens/my_grievances_screen.dart';
import 'package:student_grivence_portal/screens/submit_grievance_screen.dart';
import 'package:student_grivence_portal/widgets/topbar.dart';
import '../widgets/sidebar.dart';
import '../screens/dashboard_screen.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int selectedIndex = 0;

  void handleSidebarSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
      return const SubmitGrievanceScreen();
      case 2:
        return const MyGrievancesScreen();
      case 3:
        return Center(child: Text('Notices (Coming Soon)'));
      case 4:
        return Center(child: Text('Settings (Coming Soon)'));
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBar(loadingUser: false, userName: ''), // 👈 Add this
          Expanded(
            child: Row(
              children: [
                Sidebar(
                  selectedIndex: selectedIndex,
                  onItemSelected: handleSidebarSelection,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: _getSelectedScreen(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
