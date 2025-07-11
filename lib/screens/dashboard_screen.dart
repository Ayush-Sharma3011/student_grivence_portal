
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
   const DashboardScreen({super.key});
  
  


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Main Content
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thought Of The Day',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
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
                const SizedBox(height: 24),
      
                // Grievance Summary Cards
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
      
                // Notice Board
                const Text(
                  'Notices',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                _buildNoticeBoard(),
                const SizedBox(height: 24),
      
                // Calendar Placeholder
                const Text(
                  'Calendar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E2D1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Calendar Widget Coming Soon',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          const SizedBox(width: 24),
      
          // Right Panel
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Teacher',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ...List.generate(3, (index) {
                  return _buildTeacherCard('Treepti Rawat');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
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
                  fontSize: 16,
                )),
            const Spacer(),
            Text('$count Issues',
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeBoard() {
    return Container(
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
    );
  }

  Widget _buildTeacherCard(String name) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'),
        ),
        title: Text(name),
      ),
    );
  }
}
