import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wally/About.dart';
import 'package:wally/Models/wall.dart';
import 'package:http/http.dart' as http;
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:wally/Search.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'cetogaries.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: WallpaperHome(),
    );
  }
}

class WallpaperHome extends StatefulWidget {
  @override
  State<WallpaperHome> createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  List<Wall> wallpaperData = [];
  var data;
  List<String> k = [
    "India",
    "boat",
    "Weather",
    "Ocean",
    "4k",
    "Mountains",
    "Sky",
  ];

  Future<List<Wall>> getWall() async {
    var y = Random();
    int xy = y.nextInt(7);
    print(xy);
    String x = k[xy];
    wallpaperData.clear();
    final response = await http.get(Uri.parse(
        "https://api.pexels.com/v1/search?query=${x}&per_page=20&page=${1}"));
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data["photos"]) {
        wallpaperData.add(Wall.fromJson(i));
      }
      return wallpaperData;
    } else {
      return wallpaperData;
    }
  }

  int index = 0;
  Widget showWall(int i, double screen, double hei) {
    double multi = 0.5;
    if (hei >= 800) {
      multi = 0.6;
    } else {
      multi = 0.5;
    }
    print(hei);
    return AlertDialog(
      backgroundColor: Color.fromARGB(212, 255, 255, 255),
      iconPadding: EdgeInsets.fromLTRB(0, 20, 0, 5),
      icon: Center(
        child: Text(
          "Wall-Paper",
          style: TextStyle(
              color: Color.fromARGB(255, 210, 120, 10),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      scrollable: true,
      contentPadding: EdgeInsets.all(12),
      title: Text(wallpaperData[i].photographer.toString()),
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w100, fontSize: 20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            width: screen,
            height: hei * multi,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        wallpaperData[i].src!.portrait.toString()))),
          ),
          ElevatedButton(
              onPressed: () async {
                await AsyncWallpaper.setWallpaper(
                    url: wallpaperData[i].src!.large2X.toString(),
                    wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                    goToHome: true);
              },
              child: Text("Home Screen")),
          ElevatedButton(
              onPressed: () async {
                await AsyncWallpaper.setWallpaper(
                    url: wallpaperData[i].src!.large2X.toString(),
                    wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
                    goToHome: true);
              },
              child: Text("Lock Screen")),
          ElevatedButton(
              onPressed: () async {
                await AsyncWallpaper.setWallpaper(
                    url: wallpaperData[i].src!.large2X.toString(),
                    wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                    goToHome: true);
              },
              child: Text("Both")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close")),
        ],
      ),
    );
  }

  var background = Colors.black;
  var forground = Colors.white;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          child: GNav(
              onTabChange: (value) {
                setState(() {
                  index = value;
                });
              },
              padding: EdgeInsets.all(14),
              style: GnavStyle.google,
              gap: 10,
              activeColor: Colors.white,
              color: Colors.white,
              tabActiveBorder: Border.all(color: Colors.white),
              haptic: true,
              backgroundColor: Color.fromARGB(0, 255, 255, 255),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: "Home",
                ),
                GButton(
                  icon: LineIcons.search,
                  text: "Search",
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: "About",
                )
              ]),
        ),
        backgroundColor: Colors.black,
        appBar: (index == 1)
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text("Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 35)),
              )
            : (index == 2)
                ? AppBar(
                    backgroundColor: background,
                    title: Center(
                      child: GradientText(
                        'Wall-Paper',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                        colors: [
                          Colors.amber,
                          Colors.red,
                          Color.fromARGB(255, 135, 92, 210),
                        ],
                      ),
                    ),
                  )
                : AppBar(
                    backgroundColor: background,
                    title: Text("Wall-Paper",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 35)),
                  ),
        body: (index == 0)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: getWall(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    10, height * 0.025, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "FOR YOU",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromARGB(58, 51, 51, 51),
                                          blurRadius: 12)
                                    ],
                                    border: Border.symmetric(
                                        horizontal: BorderSide(
                                            color: Color.fromARGB(
                                                62, 255, 193, 7))),
                                  ),
                                  width: double.infinity,
                                  height: (height >= 800)
                                      ? height * 0.43
                                      : (height >= 750)
                                          ? height * 0.34
                                          : height * 0.24,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: wallpaperData.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return showWall(index,
                                                            width, height);
                                                      });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(15),
                                                  height: (height >= 800)
                                                      ? height * 0.36
                                                      : (height >= 750)
                                                          ? height * 0.27
                                                          : height * 0.15,
                                                  width: (height >= 800)
                                                      ? 200
                                                      : 150,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              wallpaperData[
                                                                      index]
                                                                  .src!
                                                                  .large
                                                                  .toString()))),
                                                )),
                                            Text(
                                                wallpaperData[index]
                                                    .photographer
                                                    .toString(),
                                                style: TextStyle(
                                                    color: forground,
                                                    fontWeight:
                                                        FontWeight.w800))
                                          ],
                                        );
                                      })),
                            ],
                          );
                        }
                      }),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "category".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        Catogaries(
                            "https://images.pexels.com/photos/3435272/pexels-photo-3435272.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "Abstract"),
                        Catogaries(
                            "https://images.pexels.com/photos/9754/mountains-clouds-forest-fog.jpg?auto=compress&cs=tinysrgb&h=350",
                            "Mountains"),
                        Catogaries(
                            "https://images.pexels.com/photos/206359/pexels-photo-206359.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "Scenery"),
                        Catogaries(
                            "https://images.pexels.com/photos/1169754/pexels-photo-1169754.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "Space"),
                      ],
                    ),
                  ),
                ],
              )
            : (index == 1)
                ? Search()
                : About());
  }
}
