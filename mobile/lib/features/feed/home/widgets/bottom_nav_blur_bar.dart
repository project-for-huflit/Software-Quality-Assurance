import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBlurBar extends StatefulWidget {
  const BottomNavBlurBar({ super.key });

  @override
  _BottomNavBlurBarState createState() => _BottomNavBlurBarState();
}

class _BottomNavBlurBarState extends State<BottomNavBlurBar> {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CrystalNavigationBar(
          // currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          currentIndex: 0,
          // indicatorColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: Icons.home_outlined,
              unselectedIcon: Icons.home_outlined,
              selectedColor: Colors.black,
            ),

            /// Favourite
            CrystalNavigationBarItem(
              icon: Icons.pie_chart_outline,
              unselectedIcon: Icons.pie_chart_outline,
              selectedColor: Colors.black,
            ),

            /// Add
            CrystalNavigationBarItem(
              icon: Icons.play_circle_outline_sharp,
              unselectedIcon: Icons.play_circle_outline_sharp,
              selectedColor: Colors.black,
            ),

            /// Search
            CrystalNavigationBarItem(
                icon: Icons.wallet_outlined,
                unselectedIcon: Icons.wallet_outlined,
                selectedColor: Colors.black),

            /// Profile
            CrystalNavigationBarItem(
              icon: Icons.person_outline,
              unselectedIcon: Icons.person_outline,
              selectedColor: Colors.black,
            ),
          ],
        ),
      );
  }


  _handleIndexChanged(int p1) {

  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(64, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}