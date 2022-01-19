import 'package:flutter/material.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  static const routeName = '/edit_post';

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final _titleController = TextEditingController();
    final _bodyController = TextEditingController();
    final _imageController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Post Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: data['title'],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: data['body'],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: data['image'],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ));
  }
}
