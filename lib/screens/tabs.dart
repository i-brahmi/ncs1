import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/screens/bin_map_page.dart';
import 'package:ncs/screens/home.dart';
import 'package:ncs/screens/my_bookings_screen.dart';
import 'package:ncs/screens/settings.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int selindex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const Home(),
      const MyQRcodeScreen(),
      const MapsScreen(),
      const Settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: selindex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        // maxWidth: 12,
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 400),
        // key: bottomNavigationKey,
        index: selindex,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            selindex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(
            child: selindex == 0
                ? SvgPicture.asset(
                    "lib/assets/icons/home.svg",
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    "assets/notcoloredhome.svg",
                    fit: BoxFit.cover,
                  ),
            label: "Home",
            labelStyle: GoogleFonts.poppins(
              color: AppStyle.maincolor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          CurvedNavigationBarItem(
            child: selindex != 1
                ? SvgPicture.asset(
                    "lib/assets/icons/qrcodeblack.svg",
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    "lib/assets/icons/qrcode.svg",
                    fit: BoxFit.cover,
                  ),
            label: "QR code",
            labelStyle: GoogleFonts.poppins(
              color: AppStyle.maincolor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          CurvedNavigationBarItem(
            child: selindex != 2
                ? Image.asset(
                    "lib/assets/images/locationpin.png",
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "lib/assets/images/locationpin.png",
                    fit: BoxFit.cover,
                  ),
            label: "Map",
            labelStyle: GoogleFonts.poppins(
              color: AppStyle.maincolor,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          CurvedNavigationBarItem(
            child: selindex != 3
                ? SvgPicture.asset("assets/profil.svg", fit: BoxFit.cover)
                : SvgPicture.asset(
                    "assets/coloredprofile.svg",
                    fit: BoxFit.cover,
                  ),
            label: "Profile",
            labelStyle: GoogleFonts.poppins(
              color: AppStyle.maincolor,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
