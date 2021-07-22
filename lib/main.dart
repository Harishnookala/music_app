
import 'dart:io' show Directory, FileStat, FileSystemEntity;

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:permission_handler/permission_handler.dart';

import 'Albums.dart';


void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "New Task",
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List dirPaths=[];
  late String type;
  late TabController _tabController;

  void getFiles() async {

    if (await Permission.storage.request().isGranted) {
      print('Permission granted');
    }

  }

  @override
  void initState() {
    getFiles();
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: new Text("Music"),
        bottom: TabBar(
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.white,
          tabs: [
            Container(
              child: new Text("Songs",),
              margin: EdgeInsets.all(12.3),
            ),
            Container(child: new Text("Albums"),
              margin: EdgeInsets.all(12.3),
            ),

          ],
          controller: _tabController,
          indicatorColor: Colors.lightGreenAccent,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: dirPaths != null
          ? TabBarView(
        children: [
          dirPaths == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            //if file/folder list is grabbed, then show here
            itemCount: dirPaths.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                    title: Container(
                        child: Text(dirPaths.toString())),
                    leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40),
                                topLeft: Radius.circular(40)
                            ),
                            color: Colors.green),
                        child: Icon(Icons.play_arrow_outlined,size: 26,)),

                    onTap: (){

                    },

                  ));
            },
          ),
           Albums(),
        ],
        controller: _tabController,
      )
          : Container(),
    );
  }
}


