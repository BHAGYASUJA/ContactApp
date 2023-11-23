import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bodyController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save the new post and pop the screen
                Navigator.pop(
                  context,
                  {
                    'userId': 1, // For simplicity, hardcoding the user id to 1
                    'id': DateTime.now().millisecondsSinceEpoch,
                    'title': titleController.text,
                    'body': bodyController.text,
                  },
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
