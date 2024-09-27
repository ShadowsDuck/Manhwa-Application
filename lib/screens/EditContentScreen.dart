import 'package:flutter/material.dart';

class EditContentScreen extends StatefulWidget {
  final Map<String, String> content; // Pass the content to edit

  const EditContentScreen({super.key, required this.content});

  @override
  _EditContentScreenState createState() => _EditContentScreenState();
}

class _EditContentScreenState extends State<EditContentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String authors;
  late String genres;
  late String status;
  late String published;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    // Initialize the form fields with the passed content
    title = widget.content['title'] ?? '';
    authors = widget.content['authors'] ?? '';
    genres = widget.content['genres'] ?? '';
    status = widget.content['status'] ?? '';
    published = widget.content['published'] ?? '';
    imageUrl = widget.content['imageUrl'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: title,
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
                initialValue: authors,
                decoration: const InputDecoration(labelText: 'Authors'),
                onSaved: (value) {
                  authors = value ?? '';
                },
              ),
              TextFormField(
                initialValue: genres,
                decoration: const InputDecoration(labelText: 'Genres'),
                onSaved: (value) {
                  genres = value ?? '';
                },
              ),
              TextFormField(
                initialValue: status,
                decoration: const InputDecoration(labelText: 'Status'),
                onSaved: (value) {
                  status = value ?? '';
                },
              ),
              TextFormField(
                initialValue: published,
                decoration: const InputDecoration(labelText: 'Published Year'),
                onSaved: (value) {
                  published = value ?? '';
                },
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) {
                  imageUrl = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Pass updated content back
                    Navigator.pop(context, {
                      'title': title,
                      'authors': authors,
                      'genres': genres,
                      'status': status,
                      'published': published,
                      'imageUrl': imageUrl,
                    });
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
