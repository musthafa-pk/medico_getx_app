import 'package:flutter/material.dart';
import 'package:medico_getx_app/Utils/util.dart';
import 'package:medico_getx_app/views/HistoryPage/historyPage.dart';
import 'package:medico_getx_app/views/HomePage.dart';
import 'package:medico_getx_app/views/offersPage/offersPage.dart';
import 'package:get/get.dart';
import '../constents.dart';
class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {

  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<Widget> _widgetOptions(BuildContext context) => <Widget>[
    HomePage(),
    HistoryPage(),
    OffersPage(),
    Obx(
      () {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle drawer item click
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle drawer item click
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    ),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: _widgetOptions(context).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: 'History'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: '%'
          ),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 15,),
              label: ''
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[800],
        unselectedItemColor: Colors.teal[500],
        unselectedLabelStyle: TextStyle(color: Colors.teal[700]),
        onTap:(index){
          if(index == 3){
            _scaffoldKey.currentState?.openDrawer();
          }else{
            _onItemTapped(index);
          }
        }
      ),
    );
  }
}
