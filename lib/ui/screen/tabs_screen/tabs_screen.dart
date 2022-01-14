import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: News',
      style: optionStyle,
    ),
    Text(
      'Index 1: Events',
      style: optionStyle,
    ),
    Text(
      'Index 2: Roster',
      style: optionStyle,
    ),
    Text(
      'Index 3: Sponsors',
      style: optionStyle,
    ),
    Text(
      'Index 4: Contact',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
}
