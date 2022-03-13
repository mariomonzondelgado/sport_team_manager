import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/service/auth_service.dart';
import 'package:sport_team_manager/ui/screen/contact_tab_screen/contact_tab_screen.dart';
import 'package:sport_team_manager/ui/screen/events_tab_screen/event_tab_screen.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/news_tab_screen.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/roster_tab_screen.dart';
import 'package:sport_team_manager/ui/screen/sponsors_tab_screen/sponsors_tab_screen.dart';

class TabsScreen extends StatefulWidget {
  final String memberId;

  TabsScreen({required this.memberId});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  late Person currentPerson;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final AuthService _authService = AuthService();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () => _authService.signout(),
              icon: const Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.black87,
              ),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("members")
                .doc(widget.memberId)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return Container();
              } else {
                if (!snapshot.data["isAdmin"]) {
                  currentPerson = Person.fromDB(
                      firstName: snapshot.data["firstName"],
                      lastName: snapshot.data["lastName"],
                      email: snapshot.data["email"],
                      isAdmin: snapshot.data["isAdmin"]);
                } else {
                  currentPerson = Admin.fromDB(
                      firstName: snapshot.data["firstName"],
                      lastName: snapshot.data["lastName"],
                      email: snapshot.data["email"],
                      isAdmin: snapshot.data["isAdmin"]);
                }

                return Scaffold(
                  body: Center(
                    child: screensController(currentPerson),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.amber,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.newspaper),
                        label: 'News',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.calendar),
                        label: 'Events',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.peopleArrows),
                        label: 'Roster',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.medal),
                        label: 'Sponsors',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.phone),
                        label: 'Contact',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black26,
                    onTap: _onItemTapped,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget? screensController(Person person) {
    final List<Widget> _tabScreens = [
      NewsTabScreen(person: person),
      EventsTabScreen(person: person),
      RosterTabScreen(person: person),
      const SponsorsTabScreen(),
      const ContactTabScreen(),
    ];

    return _tabScreens[_selectedIndex];
  }
}
