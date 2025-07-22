import 'package:flutter/material.dart';
import 'package:student_grivence_portal/admin/screens/admin_dashboard.dart';
import 'package:student_grivence_portal/admin/screens/manage_grievances.dart';
import 'package:student_grivence_portal/admin/screens/manage_users_screen.dart';
import 'package:student_grivence_portal/admin/widgets/admin_sidebar.dart';
import 'package:student_grivence_portal/widgets/topbar.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int selectedIndex = 0;

  void handleSidebarSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return const AdminDashboard();
      case 1:
        return const ManageGrievancesScreen();
      case 2:
        return const ManageUsersScreen();
      default:
        return const AdminDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBar(loadingUser: false, userName: "Admin"),
          Expanded(
            child: Row(
              children: [
                AdminSidebar(
                  selectedIndex: selectedIndex,
                  onItemSelected: handleSidebarSelection,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    color: const Color(0xFFF5F6FA),
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
