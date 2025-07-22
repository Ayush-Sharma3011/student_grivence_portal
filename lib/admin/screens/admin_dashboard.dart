import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});


  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('grievances').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final grievances = snapshot.data!.docs;
        int pending = 0, inProgress = 0, resolved = 0;

        for (var doc in grievances) {
          final status = doc['status'];
          if (status == 'Pending') {pending++;}
          else if (status == 'In Progress') {inProgress++;}
          else if (status == 'Resolved') {resolved++;}
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Admin Dashboard", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildStatCard('Pending', pending, Colors.orange),
                  const SizedBox(width: 16),
                  _buildStatCard('In Progress', inProgress, Colors.blue),
                  const SizedBox(width: 16),
                  _buildStatCard('Resolved', resolved, Colors.green),
                  const SizedBox(width: 16),
                  _buildStatCard('Total', grievances.length, Colors.deepPurple),
                ],
              ),
              const SizedBox(height: 32),
              const Text("Latest Submissions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...grievances
                  .take(5)
                  .map((doc) => _buildLatestItem(doc.data() as Map<String, dynamic>))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text("$count", style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestItem(Map<String, dynamic> data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(data['subject'] ?? 'No subject'),
        subtitle: Text('By: ${data['user'] ?? "Unknown"}'),
        trailing: Chip(
          label: Text(data['status'] ?? 'Unknown'),
          backgroundColor: _statusColor(data['status'] ?? ''),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange.shade100;
      case 'In Progress':
        return Colors.blue.shade100;
      case 'Resolved':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade300;
    }
  }
}
