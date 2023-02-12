import 'package:http/http.dart' as http;
import 'package:wally/Models/wall.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:async_wallpaper/async_wallpaper.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int pageNo = 1;
  String search = "";
  void val(String x) {
    print(x);
  }

  List<Wall> wallpaperData = [];
  Future<List<Wall>> getWall(String top) async {
    String x = top;
    wallpaperData.clear();
    final response = await http.get(Uri.parse(
        "https://api.pexels.com/v1/search?query=${x}&per_page=80&page=${pageNo}"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      wallpaperData = [];
      for (Map i in data["photos"]) {
        wallpaperData.add(Wall.fromJson(i));
      }
      print(wallpaperData.length);
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

  final searchValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          child: TextField(
            focusNode: FocusNode(canRequestFocus: false),
            autofocus: false,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    search = searchValue.text.toString();
                    val(search);
                  });
                },
              ),
            ),
            controller: searchValue,
            onSubmitted: (value) {
              setState(() {
                search = searchValue.text.toString();
              });
            },
          ),
        ),
        (search == '')
            ? Expanded(
                child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Whats in Your mind....",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ))
            : Expanded(
                child: Container(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getWall(search),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            return Column(
                              children: [
                                Container(
                                  height: (height >= 800)
                                      ? height * 0.67
                                      : (height >= 750)
                                          ? height * 0.62
                                          : height * 0.594,
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
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: !(pageNo == 1)
                                            ? () {
                                                setState(() {
                                                  pageNo--;
                                                });
                                              }
                                            : null,
                                        child: Text("<<Previous")),
                                    ElevatedButton(
                                        onPressed: !(wallpaperData.length == 0)
                                            ? () {
                                                setState(() {
                                                  pageNo++;
                                                });
                                              }
                                            : null,
                                        child: Text("Next>>"))
                                  ],
                                )
                              ],
                            );
                          }
                        })
                  ],
                ),
              )),
      ],
    );
  }
}
