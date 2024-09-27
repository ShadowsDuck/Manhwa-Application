import 'package:flutter/material.dart';

class AddContentScreen extends StatefulWidget {
  @override
  _AddContentScreenState createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String authors = '';
  String genres = '';
  String status = '';
  String published = '';
  String imageUrl = ''; // For storing the image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Authors'),
                onSaved: (value) {
                  authors = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Genres'),
                onSaved: (value) {
                  genres = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status'),
                onSaved: (value) {
                  status = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Published Year'),
                onSaved: (value) {
                  published = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Image URL'), // Add URL field
                onSaved: (value) {
                  imageUrl = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Navigator.pop(context, {
                      'title': title,
                      'authors': authors,
                      'genres': genres,
                      'status': status,
                      'published': published,
                      'imageUrl': imageUrl, // Pass image URL back to HomeScreen
                    });
                  }
                },
                child: const Text('Add Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
