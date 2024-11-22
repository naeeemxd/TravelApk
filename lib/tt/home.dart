import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // firebse initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference aaa = FirebaseFirestore.instance.collection('aaa');

  void delete(aaaid) {
    aaa.doc(aaaid).delete().then((value) => print('deleted'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations'),
      ),
      body: StreamBuilder(
        stream: aaa.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs
                  .length, // Replace with the actual length of your data
              itemBuilder: (context, index) {
                final DocumentSnapshot aaasnap = snapshot.data.docs[index];
                return Card(
                  child: ListTile(
                    title:
                        Text(aaasnap['name']), // Replace with your data's title
                    subtitle: Text(
                        aaasnap['age']), // Replace with your data's description
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit', arguments: {
                              'name': aaasnap['name'],
                              'age': aaasnap['age'],
                              'id': aaasnap.id
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            delete(aaasnap.id);
                            // Delete operation
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
