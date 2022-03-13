import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/repository/content_repository.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/widget/loading_widget.dart';

class EdirEventPopup extends ConsumerStatefulWidget {
  const EdirEventPopup({
    Key? key,
    required this.admin,
    required this.event,
  }) : super(key: key);

  final Admin admin;
  final Event event;

  @override
  _EdirEventPopupState createState() => _EdirEventPopupState();
}

class _EdirEventPopupState extends ConsumerState<EdirEventPopup> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool loading = false;

  @override
  void initState() {
    setState(() {
      _titleController = TextEditingController(text: widget.event.title);
      _bodyController = TextEditingController(text: widget.event.body);
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
              child: _editEventWidget(),
            ),
          ),
          Positioned(
            child: loading ? LoadingWidget() : Container(),
          ),
        ],
      ),
    );
  }

  Widget _editEventWidget() {
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
            "Editar Evento",
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
              keyboardType: TextInputType.text,
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
            TextFormField(
              controller: _bodyController,
              keyboardType: TextInputType.text,
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
                await ContentRepository.updateEvent(
                  ref,
                  widget.event.eventId,
                  _titleController.text,
                  _bodyController.text,
                );
                ControllerToastMessages.genericMessage(
                    "Se actualizó el evento!");
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
