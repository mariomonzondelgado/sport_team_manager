import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/repository/content_repository.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class AddEventPopup extends ConsumerStatefulWidget {
  const AddEventPopup({Key? key, required this.admin}) : super(key: key);

  final Admin admin;

  @override
  _AddEventPopupState createState() => _AddEventPopupState();
}

class _AddEventPopupState extends ConsumerState<AddEventPopup> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  StoreImage image = StoreImage();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.height,
      height: size.height,
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _addEventWidget(),
            ),
          ),
          Positioned(
            child: loading ? LoadingWidget() : Container(),
          ),
        ],
      ),
    );
  }

  Widget _addEventWidget() {
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
            "Nuevo Evento",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: [
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Título',
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
              controller: _bodyController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Texto',
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
                await ContentRepository.addEvent(
                    ref, _titleController.text, _bodyController.text);
                ControllerToastMessages.genericMessage(
                    "Se añadió un nuevo evento!");
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
            child: Text('Añadir'),
          ),
        )
      ],
    );
  }
}
