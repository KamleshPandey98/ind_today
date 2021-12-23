import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:india_today/views/home_page.dart';
import 'package:india_today/views/talk_to_astrologer_page.dart';

import '../custom_styles.dart';
import '../reusable_widgets.dart';

class BottomNavScreen extends StatefulWidget {
  final int? gettingPageIndex;
  const BottomNavScreen({Key? key, this.gettingPageIndex}) : super(key: key);
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  final _screensNavigation = [
    const MyHomePage(),
    const TalkToAstrologer(),
    const TalkToAstrologer(),
    const TalkToAstrologer(),
  ];
  DateTime? current;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.gettingPageIndex ?? 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popBack,
      child: Scaffold(
        // body: Stack(
        //     children: _screensNavigation
        //         .asMap()
        //         .map((i, screen) => MapEntry(
        //       i,
        //       Offstage(
        //         offstage: _selectedIndex != i,
        //         child: screen,
        //       ),
        //     ))
        //         .values
        //         .toList()
        // ),
        body: _screensNavigation[_selectedIndex],
        backgroundColor: CustomStyles.mainParentWhiteColor,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: CustomStyles.mainParentWhiteColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          unselectedItemColor: CustomStyles.black,
          // selectedItemColor: CustomStyles.activeBtmNavIconColor,
          unselectedIconTheme: const IconThemeData(color: Colors.white70),
          // iconSize: 25,
          // selectedFontSize: 25.0,
          // unselectedFontSize: 25.0,
          iconSize: 20,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          items: [
            BottomNavigationBarItem(
              icon: ReusableWidgets.pngLogoHolder(
                text: "Home",
                assetPath: "assets/images/home.png",
                height: 20.0,
                width: 20.0,
                color: Colors.grey,
              ),
              activeIcon: ReusableWidgets.pngLogoHolder(
                  text: "Home",
                  assetPath: "assets/images/home.png",
                  height: 20.0,
                  width: 20.0,
                  color: CustomStyles.activeBtmNavIconColor),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ReusableWidgets.pngLogoHolder(
                text: "Talk to Astrologer",
                assetPath: "assets/images/talk.png",
                height: 20.0,
                width: 20.0,
              ),
              activeIcon: ReusableWidgets.pngLogoHolder(
                  text: "Talk to Astrologer",
                  assetPath: "assets/images/talk.png",
                  height: 20.0,
                  width: 20.0,
                  color: CustomStyles.activeBtmNavIconColor),
              label: 'Talk to Astrologer',
            ),
            BottomNavigationBarItem(
              icon: ReusableWidgets.pngLogoHolder(
                text: "Ask Question",
                assetPath: "assets/images/ask.png",
                height: 20.0,
                width: 20.0,
              ),
              activeIcon: ReusableWidgets.pngLogoHolder(
                  text: "Ask Question",
                  assetPath: "assets/images/ask.png",
                  height: 20.0,
                  width: 20.0,
                  color: CustomStyles.activeBtmNavIconColor),
              label: 'Ask Question',
            ),
            BottomNavigationBarItem(
              icon: ReusableWidgets.pngLogoHolder(
                text: "Reports",
                assetPath: "assets/images/reports.png",
                height: 20.0,
                width: 20.0,
              ),
              activeIcon: ReusableWidgets.pngLogoHolder(
                  text: "Reports",
                  assetPath: "assets/images/reports.png",
                  height: 20.0,
                  width: 20.0,
                  color: CustomStyles.activeBtmNavIconColor),
              label: 'Reports',
            ),
            // BottomNavigationBarItem(
            //   icon: ReusableWidgets.pngLogoHolder(
            //     text: "Chat With Astrologer",
            //     assetPath: "assets/images/talk.png",
            //     height: 20.0,
            //     width: 20.0,
            //     // semanticsLabel: 'Acme Logo'
            //   ),
            //   activeIcon: ReusableWidgets.pngLogoHolder(
            //       text: "Chat With Astrologer",
            //       assetPath: "assets/images/talk.png",
            //       height: 20.0,
            //       width: 20.0,
            //       color: CustomStyles.activeBtmNavIconColor),
            //   label: 'Chat With Astrologer',
            // ),
          ],
        ),
      ),
    );
  }

  Future<bool> popBack() {
    DateTime now = DateTime.now();
    if (current == null ||
        now.difference(current!) > const Duration(seconds: 2)) {
      current = now;
      ReusableWidgets.showingFlutterToast(msg: "Press Again To Exit !!");
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }
}
