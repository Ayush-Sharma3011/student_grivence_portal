import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageGrievancesScreen extends StatelessWidget {
  const ManageGrievancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final grievancesRef = FirebaseFirestore.instance
        .collection('grievances')
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: grievancesRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong."));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Center(child: Text("No grievances found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final status = data['status'] ?? 'Pending';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  data['subject'] ?? 'No subject',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(data['description'] ?? 'No description'),
                    const SizedBox(height: 6),
                    Text("Submitted by: ${data['name'] ?? 'Unknown'}"),
                  ],
                ),
                trailing: DropdownButton<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                    DropdownMenuItem(value: 'Resolved', child: Text('Resolved')),
                  ],
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      FirebaseFirestore.instance
                          .collection('grievances')
                          .doc(doc.id)
                          .update({'status': newStatus});
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
