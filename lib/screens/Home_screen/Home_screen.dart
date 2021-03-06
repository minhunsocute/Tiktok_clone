import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/Insert_video.dart/inserVid_screen.dart';
import 'package:tiktok_clone/screens/Search_screen/search_screen.dart';
import 'package:tiktok_clone/screens/profileUser/profile_user_screen.dart';

import '../../widgets/icon_desgin.dart';
import '../Notification/notification.dart';
import '../home/Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String s = "";
  int _page = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void NavigatorTapped(int val) {
    _pageController.jumpToPage(val);
    setState(() {
      _page = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: (_page != 2)
              ? (_page < 2)
                  ? const Color.fromARGB(255, 136, 199, 250)
                  : const Color.fromARGB(255, 250, 45, 108)
              : Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 70,
          selectedIndex: _page,
          onDestinationSelected: (int newIndex) {
            NavigatorTapped(newIndex);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 32, 211, 234),
                size: 27,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.search,
                color: Color.fromARGB(255, 32, 211, 234),
                size: 27,
              ),
              selectedIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: 'Search',
            ),
            NavigationDestination(
              icon: IconDesgin(),
              selectedIcon: IconDesgin(),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.message_outlined,
                color: Color.fromARGB(255, 250, 45, 108),
                size: 27,
              ),
              selectedIcon: Icon(Icons.message_outlined),
              label: 'Notification',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 250, 45, 108),
                size: 27,
              ),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Home(),
          SearchScreen(),
          InserVid(),
          NotifiCationScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
