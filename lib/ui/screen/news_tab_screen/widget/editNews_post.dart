import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/other_widgets/loading_widget.dart';

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
      storeImage = StoreImage.FromUrl(pathUrl: widget.post.imageUrl);
      image = StoreImage();
      controllerTitle = TextEditingController(text: widget.post.title);
      controllerDescription = TextEditingController(text: widget.post.body);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        width: 400,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Editar Noticia",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      size: 35,
                                      color: Colors.redAccent,
                                    ),
                                  ))),
                        )
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: image.file == null
                                  ? storeImage.pathUrl == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          (storeImage.pathUrl
                                                              as String)),
                                                  fit: BoxFit.fill)),
                                        )
                                  : Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          image: DecorationImage(
                                              image: FileImage(
                                                  (image.file as File)),
                                              fit: BoxFit.fill)),
                                    )),
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  StoreImage.chooseImageFileFromCamera()
                                      .then((selectedImage) {
                                    if (selectedImage != null) {
                                      setState(() {
                                        image.file = File(selectedImage.path);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.camera,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  StoreImage.chooseImageFile()
                                      .then((selectedImage) {
                                    if (selectedImage != null) {
                                      setState(() {
                                        image.file = File((selectedImage
                                            .files.single.path as String));
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 8,
                    child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
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
                            Divider(
                              color: Colors.white,
                              height: 25,
                            ),
                            SizedBox(
                              height: 150,
                              child: TextFormField(
                                maxLines: 500,
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
                            ),
                            Divider(
                              color: Colors.white,
                              height: 25,
                            ),
                          ],
                        ))),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 140, right: 140, top: 15, bottom: 15),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            loading = true;
                            image.pathUrl = storeImage.pathUrl;
                          });
                          await widget.admin.updatePost(
                              widget.post.postId,
                              controllerTitle.text,
                              controllerDescription.text,
                              image);
                          ControllerToastMessages.genericMessage(
                              "Se actualizó el post!");
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
                  )),
                ),
              ],
            ),
            Positioned(
              child: loading ? LoadingWidget() : Container(),
            ),
          ],
        ));
  }
}
