import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyGrievancesScreen extends StatelessWidget {
  const MyGrievancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Center(child: Text("Please log in to view grievances."));
    }

    final grievancesRef = FirebaseFirestore.instance
        .collection('grievances')
        .where('uid', isEqualTo: uid);
        // .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: grievancesRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong. Please try again later."));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text("You haven't submitted any grievances yet."));
        }

        return Material(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>?;
              if (data == null) return const SizedBox();
          
              final subject = data['subject'] ?? 'No subject';
              final description = data['description'] ?? 'No description';
              final status = data['status'] ?? 'Unknown';
          
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(description),
                  ),
                  trailing: Chip(
                    label: Text(
                      status,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: _statusColor(status),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Resolved':
        return Colors.green.shade100;
      case 'In Progress':
        return Colors.orange.shade100;
      case 'Pending':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }
}
