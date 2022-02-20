import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/editNews_post.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/post_card_image_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.image,
    required this.postId,
    required this.person,
  }) : super(key: key);

  final String title;
  final String body;
  final String image;
  final String postId;
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.black54,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PostCardImage(imageUrl: image),
                PostCardTitle(
                  title: title,
                ),
                PostCardBody(
                  body: body,
                ),
              ],
            ),

            (person.isAdmin==true)?
            Container(
              width: 600,
              height: 240,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (){
                              editNewsPost(context);
                            },
                            child: Center(
                              child: Icon(
                                Icons.edit_rounded,
                                size: 40,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: ()async{
                              await (person as Admin).deletePost(postId,image);
                            },
                            child: Center(
                              child: Icon(
                                Icons.cancel,
                                size: 40,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  )
                ],
              ),
            )
                :
            Container(color: Colors.redAccent,)

          ],
        )
      ),
    );
  }

  void editNewsPost(BuildContext context) async{
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          content: Builder(
            builder: (context) {
              return EditNewsPost(
                admin: person as Admin,
                post: Post(title: title, body: body, imageUrl: image, postId: postId,date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
              );
            },
          ),
        );
      },
    );
  }



}

class PostCardTitle extends StatelessWidget {
  const PostCardTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
      ),
    );
  }
}

class PostCardBody extends StatelessWidget {
  const PostCardBody({
    Key? key,
    required this.body,
  }) : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        body,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
