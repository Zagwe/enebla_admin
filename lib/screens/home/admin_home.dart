import 'package:enebla_admin/screens/home/AccountSetting.dart';
import 'package:enebla_admin/screens/home/customer_list.dart';
import 'package:enebla_admin/screens/home/homescreen.dart';
import 'package:enebla_admin/screens/home/request.dart';
import 'package:enebla_admin/screens/home/user_list.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

class EneblaAdminHome extends StatefulWidget {
  const EneblaAdminHome({super.key});

  @override
  State<EneblaAdminHome> createState() => _EneblaAdminHomeState();
}

class _EneblaAdminHomeState extends State<EneblaAdminHome> {
  int _currentIndex = 0;
  late PageController _pageController;

  int _selectedIndex = 0;

  ////
  static final List _widgetOptions = [
    HomePage(),
    Customer(),
    User(),
    Request(),
    AccountSetting(),
  ];

  @override
  void initState() {
    super.initState();
    // _pageController = PageController();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = AppStateProvider.of(context)?.blocProvider.orderBloc;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.white24,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 6,
              activeColor: Colors.blue,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.blue,
              tabs: const [
                GButton(
                  icon: Icons.food_bank_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.restaurant,
                  text: 'Customer',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'User',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Request',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}
