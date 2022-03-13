import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class EditNewsPost extends StatefulWidget {
  final Admin admin;
  final Post post;

  EditNewsPost({
    required this.admin,
    required this.post,
  });

  @override
  _EditNewsPostState createState() => _EditNewsPostState();
}

class _EditNewsPostState extends State<EditNewsPost> {
  late TextEditingController controllerTitle;
  late TextEditingController controllerDescription;
  late StoreImage image;
  late StoreImage storeImage;
  bool loading = false;
  @override
  void initState() {
    setState(() {
      loading = false;
      storeImage = StoreImage.fromUrl(pathUrl: widget.post.imageUrl);
      image = StoreImage();
      controllerTitle = TextEditingController(text: widget.post.title);
      controllerDescription = TextEditingController(text: widget.post.body);
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
                child: _editPostWidget(),
              ),
            ),
            Positioned(
              child: loading ? LoadingWidget() : Container(),
            ),
          ],
        ));
  }

  Widget _editPostWidget() {
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
            "Editar Noticia",
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
                  image.pathUrl = storeImage.pathUrl;
                });
                await widget.admin.updatePost(widget.post.postId,
                    controllerTitle.text, controllerDescription.text, image);
                ControllerToastMessages.genericMessage("Se actualizó el post!");
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
            child: Text('Actualizar'),
          ),
        )
      ],
    );
  }
}
