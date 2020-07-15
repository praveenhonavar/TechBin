import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_bin/wallet.dart';
import 'google_map.dart';
import 'login_page.dart';
import 'about_us.dart';
import 'auth.dart';
import 'help.dart';
import 'home_page.dart';
import 'qr_code_scan.dart';

class EntryPage extends StatefulWidget {
  EntryPage({this.selectedIndex, this.auth,this.onSignOut});
   int selectedIndex;
  final BaseAuth auth;
  final VoidCallback onSignOut;
  
  @override
  _EntryPageState createState() => new _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  
  @override
  Widget build(BuildContext context) {

     void _signOut() async {
      try {
        await widget.auth.signOut();
        widget.onSignOut();
      } catch (e) {
        print(e);
      }
    }

    void _googlesignOut() async {
      try {
        await widget.auth.signOutGoogle();
        widget.onSignOut();
      } catch (e) {
        print(e);
      }
    }

    final _widgetOptions = [
      new HomePage(),
      Center(
        child: Text('Chart'),
      ),
      new Wallet(collection: randomNumber,),
      Center(
        child: Text('Setting'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
            OutlineButton(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: new Text('Search DustBin Near Me'),
                  ),
                  Icon(Icons.search),
                ]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMaps(),
                    ),
                  );
                }),
          ],
      ),
      body:  WillPopScope(
       onWillPop: () {
            SystemNavigator.pop();
            return Future.value(true);
          },
          child:Center
          (
          child: _widgetOptions.elementAt(widget.selectedIndex),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('user name'),
              accountEmail: Text('useremail@gmail.com'),
              currentAccountPicture: Image(
                image: AssetImage("lib/image/google_logo.png"),
              ),
            ),
            ListTile(
              title: new Row(children: [
                Icon(Icons.notifications),
                Text('Notificatios'),
              ]),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: new Row(children: [
                  Icon(Icons.help),
                  Text('Help'),
                ]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Help(),
                    ),
                  );
                }),
            ListTile(
                title: new Row(children: [
                  Icon(Icons.info_outline),
                  Text('About Us'),
                ]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AbooutUs()),
                  );
                }),
            ListTile(
              title: new Row(children: [
                Icon(Icons.exit_to_app),
                Text('logOut'),
              ]),
              onTap: () {
               
                googleSignIn == true ? _googlesignOut() : _signOut();
              },
            ),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text("Scan"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scanner(),
                ),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 20,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          title: Text('Chart'),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          title: Text('Wallet'),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          backgroundColor: Colors.blue,
        ),
      ],
      onTap: (index) {
        setState(() {
          _widgetOptions.elementAt(index);
          widget.selectedIndex = index;
        });
      },
      ),
    );
  }
}
