import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatelessWidget {
  const FirestorePage({super.key});
  static String id = 'Firestore Page';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Data').snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Firestore Task'),
              centerTitle: true,
            ),
            body: snapshot.hasError
                ? const Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : snapshot.hasData
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ${snapshot.data!.docs[0]['Name']}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone: ${snapshot.data!.docs[0]['Phone']}',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        });
  }
}
