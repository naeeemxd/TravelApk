import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final CollectionReference aaa = FirebaseFirestore.instance.collection('aaa');

  EditItemScreen({Key? key}) : super(key: key);

  void update(BuildContext context, String aaid) {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _titleController.text,
        'age': _descriptionController.text, 
      };

      aaa.doc(aaid).update(data).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully!')),
        );
        Navigator.of(context).pop(); // Close the screen
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update item: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    _titleController.text = args['name'] ?? '';
    _descriptionController.text = args['age'] ?? '';
    final aaaid = args['id'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => update(context, aaaid),
                child: const Text('Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
