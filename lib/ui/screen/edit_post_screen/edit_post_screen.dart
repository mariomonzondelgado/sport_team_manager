import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/provider/app_provider.dart';

class EditPostScreen extends ConsumerStatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  final String routeName = '/edit_post';

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends ConsumerState<EditPostScreen> {
  @override
  void initState() {
    ref.read(fbStorageProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storage = ref.watch(fbStorageProvider);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 3,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 10,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: storage.loadImages('news'),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> image =
                            snapshot.data![index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            dense: false,
                            leading: Image.network(image['url']),
                            trailing: IconButton(
                              onPressed: () {
                                storage.delete(image['path'], 'news');
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      storage.upload('camera', 'news');
                      setState(() {});
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text('camera')),
                ElevatedButton.icon(
                    onPressed: () {
                      storage.upload('gallery', 'news');
                      setState(() {});
                    },
                    icon: const Icon(Icons.library_add),
                    label: const Text('Gallery')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
