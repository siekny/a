import 'package:flutter/material.dart';
import 'package:htb_mobile/views/screens/category_screen.dart';
import 'package:htb_mobile/views/screens/cart/cart_screen.dart';
import 'package:htb_mobile/views/screens/home_screen.dart';
import 'package:htb_mobile/views/screens/profile_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainBottomNavigation extends StatefulWidget {
  @override
  _MainBottomNavigationState createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // Text('home'),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 15,
        backgroundColor: Colors.white,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.homeOutline,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.viewDashboardOutline,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(MdiIcons.cartOutline),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountOutline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
