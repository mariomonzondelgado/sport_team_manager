import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class AddPlayerPopup extends StatefulWidget {
  final Admin admin;

  AddPlayerPopup({required this.admin});

  @override
  _AddPlayerPopupState createState() => _AddPlayerPopupState();
}

class _AddPlayerPopupState extends State<AddPlayerPopup> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _numberController = TextEditingController();
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
                child: _addPlayerWidget(),
              ),
            ),
            Positioned(
              child: loading ? LoadingWidget() : Container(),
            ),
          ],
        ));
  }

  Widget _addPlayerWidget() {
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
                size: 28.0,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Nueva Jugador",
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
              controller: _firstNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Apellido',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _positionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Posición del jugador.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Número del jugador',
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
                await widget.admin.addPlayer(
                    _firstNameController.text,
                    _lastNameController.text,
                    _positionController.text,
                    _numberController.text,
                    image);
                ControllerToastMessages.genericMessage(
                    "Se añadió un nuevo jugador!");
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
