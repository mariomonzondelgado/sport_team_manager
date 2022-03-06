import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class EditPlayerPopup extends StatefulWidget {
  final Admin admin;
  final Player player;

  EditPlayerPopup({
    required this.admin,
    required this.player,
  });

  @override
  _EditPlayerPopupState createState() => _EditPlayerPopupState();
}

class _EditPlayerPopupState extends State<EditPlayerPopup> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _playerNumberController;
  late TextEditingController _playerPositionController;
  late StoreImage image;
  late StoreImage storeImage;
  bool loading = false;

  @override
  void initState() {
    setState(() {
      loading = false;
      image = StoreImage();
      storeImage = StoreImage.FromUrl(pathUrl: widget.player.photoUrl);
      _firstNameController =
          TextEditingController(text: widget.player.firstName);
      _lastNameController = TextEditingController(text: widget.player.lastName);
      _playerNumberController =
          TextEditingController(text: widget.player.number);
      _playerPositionController =
          TextEditingController(text: widget.player.position);
    });
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
                child: _editPlayerWidget(),
              ),
            ),
            Positioned(
              child: loading ? LoadingWidget() : Container(),
            ),
          ],
        ));
  }

  Widget _editPlayerWidget() {
    final bool _hasImageFile = image.file == null;
    final bool _hasPathUrl = storeImage.pathUrl == null;

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
            "Editar Jugador",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _hasImageFile
            ? _hasPathUrl
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  )
                : Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              (storeImage.pathUrl as String)),
                          fit: BoxFit.cover),
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
              keyboardType: TextInputType.text,
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
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.text,
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
            TextFormField(
              controller: _playerPositionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Posición',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _playerNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Número',
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
                  image.pathUrl = storeImage.pathUrl;
                });
                await widget.admin.updatePlayer(
                  widget.player.playerId,
                  _firstNameController.text,
                  _lastNameController.text,
                  _playerPositionController.text,
                  _playerNumberController.text,
                  image,
                );
                ControllerToastMessages.genericMessage(
                    "Se actualizó el jugador!");
                setState(() {
                  loading = false;
                });
                Navigator.pop(context);
              } catch (e) {
                ControllerToastMessages.genericMessage(
                    "Hubo un error, inténtalo de nuevo");
                setState(() {
                  loading = false;
                });
              }
            },
            child: const Text('Actualizar'),
          ),
        )
      ],
    );
  }
}
