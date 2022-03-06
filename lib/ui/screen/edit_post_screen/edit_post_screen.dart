// import 'package:flutter/material.dart';
//
// class EditPostScreen extends StatefulWidget {
//   const EditPostScreen({Key? key}) : super(key: key);
//
//   @override
//   _EditPostScreenState createState() => _EditPostScreenState();
// }
//
// class _EditPostScreenState extends State<EditPostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final _titleController = TextEditingController();
//     final _bodyController = TextEditingController();
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               //PostCardImage(),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _titleController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter your email',
//                 ),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _bodyController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter your email',
//                 ),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                 },
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Icon(Icons.camera),
//                         Text('CAMARA'),
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Icon(Icons.wallpaper),
//                         Text('GALERIA'),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
