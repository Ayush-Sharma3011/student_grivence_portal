import 'package:flutter/material.dart';
import 'package:student_grivence_portal/widgets/calendar_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainContent(),
                  const SizedBox(height: 24),
                  _buildRightPanel(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildMainContent()),
                  const SizedBox(width: 24),
                  Expanded(flex: 1, child: _buildRightPanel()),
                ],
              ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thought Of The Day',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '"What would life be if we had no courage to attempt anything?"\n- Van Gogh',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildStatCard('Pending', '4', Colors.orange),
            const SizedBox(width: 16),
            _buildStatCard('In Progress', '2', Colors.blue),
            const SizedBox(width: 16),
            _buildStatCard('Resolved', '6', Colors.green),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Notices',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        _buildNoticeBoard(),
        const SizedBox(height: 24),
        const Text(
          'Calendar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF1E2D1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const GrievanceCalendar(),
        ),
      ],
    );
  }

  Widget _buildRightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Admin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        ...List.generate(1, (index) {
          return _buildTeacherCard('ADMIN');
        }),
      ],
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const Spacer(),
            Text('$count Issues',
                style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeBoard() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: const [
            ListTile(
              title: Text(
                'Important notice regarding examination',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('16/12/2023'),
              trailing: Icon(Icons.info_outline),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Robotic event on coming weeks',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('16/12/2023'),
              trailing: Icon(Icons.event),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherCard(String name) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('images/teacher.png'),
        ),
        title: Text(name),
        trailing: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.phone),
          ),
      ),
    );
  }
}
