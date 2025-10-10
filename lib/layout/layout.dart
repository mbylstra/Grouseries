import 'package:flutter/material.dart'
    show
        AppBar,
        BottomNavigationBar,
        BottomNavigationBarItem,
        BottomNavigationBarType,
        BuildContext,
        Icon,
        Icons,
        MaterialPageRoute,
        Navigator,
        PopupMenuButton,
        PopupMenuEntry,
        PopupMenuItem,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Theme,
        Widget;
import '../screens/colors_page.dart' as screens;
import '../screens/home_page.dart' as screens;
import '../screens/icons_page.dart' as screens;
import '../screens/notes_page.dart' as screens;
import '../screens/profile_page.dart' as screens;
import '../screens/settings_page.dart' as screens;
import '../services/auth_service.dart' as auth;

class Layout extends StatefulWidget {
  const Layout({super.key, required this.title});

  final String title;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const screens.HomePage(),
    const screens.NotesPage(),
    const screens.IconsPage(),
    const screens.ColorsPage(),
  ];

  static const List<String> _titles = <String>[
    'Home',
    'Notes',
    'Icons',
    'Colors',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_titles[_selectedIndex]),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const screens.SettingsPage()),
                );
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const screens.ProfilePage()),
                );
              } else if (value == 'signout') {
                await auth.AuthService().signOut();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'signout',
                child: Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Icons'),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Colors'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
