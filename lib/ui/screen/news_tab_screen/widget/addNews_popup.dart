import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class AddNewsPopUp extends StatefulWidget {
  final Admin admin;
  AddNewsPopUp({required this.admin});

  @override
  _AddNewsPopUpState createState() => _AddNewsPopUpState();
}

class _AddNewsPopUpState extends State<AddNewsPopUp> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  StoreImage image = StoreImage();
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _addPostWidget(),
              ),
            ),
            Positioned(
              child: loading ? LoadingWidget() : Container(),
            ),
          ],
        ));
  }

  Widget _addPostWidget() {
    final bool _hasImageFile = image.file == null;
    // final bool _hasPathUrl = storeImage.pathUrl == null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                size: 35,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Nueva Noticia",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _hasImageFile
            ? Container(
                height: 150.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
              )
            : Container(
                height: 150.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    image: DecorationImage(
                        image: FileImage((image.file as File)),
                        fit: BoxFit.cover)),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  StoreImage.chooseImageFileFromCamera().then((selectedImage) {
                    if (selectedImage != null) {
                      setState(() {
                        image.file = File(selectedImage.path);
                      });
                    }
                  });
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  StoreImage.chooseImageFile().then((selectedImage) {
                    if (selectedImage != null) {
                      setState(() {
                        image.file =
                            File((selectedImage.files.single.path as String));
                      });
                    }
                  });
                },
                icon: const Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            TextFormField(
              controller: controllerTitle,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the title',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              maxLines: 5,
              controller: controllerDescription,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the body',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                setState(() {
                  loading = true;
                });
                await widget.admin.addPost(
                    controllerTitle.text, controllerDescription.text, image);
                ControllerToastMessages.genericMessage("Se subió el post!");
                setState(() {
                  loading = false;
                });
                Navigator.pop(context);
              } catch (e) {
                ControllerToastMessages.messageFromError(
                    "Hubo un error, inténtalo de nuevo");
                setState(() {
                  loading = false;
                });
              }
            },
            child: Text('Subir'),
          ),
        )
      ],
    );
  }
}
