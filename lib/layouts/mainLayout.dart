import 'package:flutter/material.dart';
import 'package:fzi_charging_app/providers/screenIndexProvider.dart';
import 'package:fzi_charging_app/screens/02_diary/screen_start_diary.dart';
import '../screens/03_household/screen_start_household.dart';
import '../screens/01_charging/screen_start_charging.dart';
import '../screens/04_profile/screen_start_profile.dart';
import 'themes/themeDefs/const.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {


  //region varDef
  final Widget child;
 final String? id;
  //endregion

  //region constructor
  MainLayout({required this.child, Key? key,String? id}) : this.id = id, super(key: key);

  //endregion

  //region onItemTapped
  /// Handles Item Tapping (selection) of navigation buttons
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, TagebuchScreen.id);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, HausanschlussScreen.id);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, SettingsScreen.id);
        break;
      case 0:
        Navigator.pushReplacementNamed(context, ChargingScreen.id);
        break;
    }
  }

  //endregion

 int getScreenIndex(){


    if(id == null)return 0;

    switch(id){
      case ChargingScreen.id: return 0;
      case HausanschlussScreen.id: return 2;
      case TagebuchScreen.id: return 1;
      case SettingsScreen.id: return 3;
      default: return 0;
    }
  }

  //region build
  @override
  Widget build(BuildContext context) {
    // _context =context;
    final _screenIndexProvider = Provider.of<screenIndexProvider>(context);
    int currentScreenIndex = getScreenIndex();//_screenIndexProvider.fetchCurrentScreenIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.power),
            label: 'Laden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Tagebuch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Zuhause',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: currentScreenIndex,
        selectedItemColor: kBodyText2Color,
        onTap: (idx) => {
          _onItemTapped(context, idx),
          _screenIndexProvider.updateScreenIndex(idx)
        },
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: child),
    );
  }
//endregion
}
