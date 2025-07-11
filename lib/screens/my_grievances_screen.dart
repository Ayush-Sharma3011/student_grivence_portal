import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyGrievancesScreen extends StatelessWidget {
  const MyGrievancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Center(child: Text("Please log in."));
    }

    final grievancesRef = FirebaseFirestore.instance
        .collection('grievances')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: grievancesRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Center(child: Text("No grievances found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              child: ListTile(
                title: Text(data['subject'] ?? ''),
                subtitle: Text(data['description'] ?? ''),
                trailing: Chip(
                  label: Text(data['status'] ?? 'Unknown'),
                  backgroundColor: _statusColor(data['status']),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'Resolved':
        return Colors.green.shade100;
      case 'In Progress':
        return Colors.orange.shade100;
      default:
        return Colors.red.shade100;
    }
  }
}
