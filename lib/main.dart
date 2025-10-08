import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart'
    show
        AppBar,
        BottomNavigationBar,
        BottomNavigationBarItem,
        BuildContext,
        Card,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        ConnectionState,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        GridView,
        Icon,
        IconData,
        Icons,
        ListView,
        MaterialApp,
        MaterialColor,
        MaterialPageRoute,
        Navigator,
        NeverScrollableScrollPhysics,
        Padding,
        PopupMenuButton,
        PopupMenuEntry,
        PopupMenuItem,
        Row,
        Scaffold,
        SliverGridDelegateWithFixedCrossAxisCount,
        SizedBox,
        State,
        StatefulWidget,
        StatelessWidget,
        StreamBuilder,
        Text,
        TextStyle,
        Theme,
        Widget,
        runApp,
        WidgetsFlutterBinding,
        BottomNavigationBarType,
        FontWeight;
import 'firebase_options.dart' as firebase_options;
import 'services/auth_service.dart' as auth;
import 'screens/sign_in_screen.dart' as screens;
import 'screens/notes_page.dart' as screens_notes;
import 'theme.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp(
    options: firebase_options.DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.appTheme,
      home: StreamBuilder(
        stream: auth.AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            return const MyHomePage(title: 'Flutter Demo Home Page');
          }

          return const screens.SignInScreen();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flutter Template Project',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'Features:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(Icons.security, 'Firebase Authentication'),
          _buildFeatureItem(Icons.storage, 'Firebase Database'),
          _buildFeatureItem(Icons.android, 'Android Support'),
          _buildFeatureItem(Icons.apple, 'iOS Support'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  static final List<IconData> _icons = [
    Icons.home,
    Icons.star,
    Icons.favorite,
    Icons.settings,
    Icons.search,
    Icons.person,
    Icons.add,
    Icons.edit,
    Icons.delete,
    Icons.save,
    Icons.share,
    Icons.check,
    Icons.close,
    Icons.menu,
    Icons.arrow_back,
    Icons.arrow_forward,
    Icons.arrow_upward,
    Icons.arrow_downward,
    Icons.refresh,
    Icons.info,
    Icons.warning,
    Icons.error,
    Icons.help,
    Icons.notifications,
    Icons.email,
    Icons.phone,
    Icons.message,
    Icons.camera,
    Icons.photo,
    Icons.video_camera_back,
    Icons.music_note,
    Icons.volume_up,
    Icons.volume_down,
    Icons.volume_off,
    Icons.play_arrow,
    Icons.pause,
    Icons.stop,
    Icons.skip_next,
    Icons.skip_previous,
    Icons.fast_forward,
    Icons.fast_rewind,
    Icons.calendar_today,
    Icons.access_time,
    Icons.lock,
    Icons.lock_open,
    Icons.visibility,
    Icons.visibility_off,
    Icons.cloud,
    Icons.cloud_upload,
    Icons.cloud_download,
    Icons.attachment,
    Icons.folder,
    Icons.folder_open,
    Icons.insert_drive_file,
    Icons.description,
    Icons.picture_as_pdf,
    Icons.image,
    Icons.location_on,
    Icons.map,
    Icons.navigation,
    Icons.explore,
    Icons.directions,
    Icons.local_cafe,
    Icons.local_dining,
    Icons.local_hospital,
    Icons.local_hotel,
    Icons.local_pharmacy,
    Icons.shopping_cart,
    Icons.shopping_bag,
    Icons.store,
    Icons.card_giftcard,
    Icons.credit_card,
    Icons.account_balance,
    Icons.monetization_on,
    Icons.trending_up,
    Icons.trending_down,
    Icons.bar_chart,
    Icons.pie_chart,
    Icons.show_chart,
    Icons.timeline,
    Icons.language,
    Icons.translate,
    Icons.public,
    Icons.vpn_lock,
    Icons.wifi,
    Icons.bluetooth,
    Icons.battery_full,
    Icons.brightness_high,
    Icons.brightness_low,
    Icons.flashlight_on,
    Icons.flashlight_off,
    Icons.airplanemode_active,
    Icons.print,
    Icons.computer,
    Icons.keyboard,
    Icons.mouse,
    Icons.headset,
    Icons.watch,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        return Card(child: Center(child: Icon(_icons[index], size: 32.0)));
      },
    );
  }
}

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  static final List<MaterialColor> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  static final List<int> _shades = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _colors.length,
      itemBuilder: (context, index) {
        final color = _colors[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _getColorName(color),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 1.5,
              ),
              itemCount: _shades.length,
              itemBuilder: (context, shadeIndex) {
                final shade = _shades[shadeIndex];
                return Container(
                  color: color[shade],
                  child: Center(
                    child: Text(
                      '$shade',
                      style: TextStyle(
                        color: shade >= 500 ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  String _getColorName(MaterialColor color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.deepPurple) return 'Deep Purple';
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.lightBlue) return 'Light Blue';
    if (color == Colors.cyan) return 'Cyan';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.green) return 'Green';
    if (color == Colors.lightGreen) return 'Light Green';
    if (color == Colors.lime) return 'Lime';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.amber) return 'Amber';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.deepOrange) return 'Deep Orange';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.grey) return 'Grey';
    if (color == Colors.blueGrey) return 'Blue Grey';
    return 'Unknown';
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const screens_notes.NotesPage(),
    const IconsPage(),
    const ColorsPage(),
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
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
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
