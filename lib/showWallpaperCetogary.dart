import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wally/TopBar.dart';
import 'Models/wall.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

var background = Colors.black;
var forground = Colors.white;

class ShowWallpaperCetogaries extends StatefulWidget {
  String nam;
  ShowWallpaperCetogaries(this.nam);

  @override
  State<ShowWallpaperCetogaries> createState() =>
      _ShowWallpaperCetogariesState(nam);
}

class _ShowWallpaperCetogariesState extends State<ShowWallpaperCetogaries> {
  String top;
  int page = 1;
  _ShowWallpaperCetogariesState(this.top);
  List<Wall> wallpaperData = [];
  Future<List<Wall>> getWall() async {
    String x = top;
    wallpaperData.clear();
    final response = await http.get(Uri.parse(
        "https://api.pexels.com/v1/search?query=${x}&per_page=20&page=${page}"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data["photos"]) {
        wallpaperData.add(Wall.fromJson(i));
      }
      return wallpaperData;
    } else {
      return wallpaperData;
    }
  }

  Widget showWall(int i, double screen, double hei) {
    double multi = 0.5;
    if (hei >= 800) {
      multi = 0.6;
    } else {
      multi = 0.5;
    }
    return AlertDialog(
      backgroundColor: Color.fromARGB(212, 255, 255, 255),
      iconPadding: EdgeInsets.fromLTRB(0, 20, 0, 5),
      icon: Center(
        child: Text(
          "Wally",
          style: TextStyle(
              color: Color.fromARGB(255, 208, 96, 4),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      scrollable: true,
      contentPadding: EdgeInsets.all(12),
      title: Text(wallpaperData[i].photographer.toString()),
      titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.w100,
          fontSize: 20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            width: screen,
            height: hei * multi,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Color.fromARGB(195, 0, 0, 0), width: 2),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size: 30,
              ),
              color: Colors.white),
          title: TopBar(top),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: getWall(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return !(wallpaperData.length == 0)
                        ? Column(
                            children: [
                              Container(
                                height: (height >= 800)
                                    ? height * 0.83
                                    : height * 0.8,
                                width: width,
                                child: GridView.builder(
                                    physics: BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    itemCount: wallpaperData.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.55,
                                    ),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return showWall(
                                                    index, width, height);
                                              });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      wallpaperData[index]
                                                          .src!
                                                          .large2X
                                                          .toString())),
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      );
                                    }),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: !(page == 1)
                                          ? () {
                                              setState(() {
                                                page--;
                                              });
                                            }
                                          : null,
                                      child: Text("<<Previous")),
                                  ElevatedButton(
                                      onPressed: () {
                                        !(page == 500)
                                            ? setState(() {
                                                page++;
                                              })
                                            : null;
                                      },
                                      child: Text("Next>>"))
                                ],
                              )
                            ],
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: height * 0.87,
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    "Please wait..",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                                CircularProgressIndicator.adaptive(),
                              ],
                            ),
                          );
                  }
                })
          ],
        ));
  }
}
