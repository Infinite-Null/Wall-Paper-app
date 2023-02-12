import 'package:flutter/material.dart';
import 'package:wally/showWallpaperCetogary.dart';

class Catogaries extends StatefulWidget {
  String ur;
  String na;
  Catogaries(this.ur, this.na);
  @override
  State<Catogaries> createState() => _CatogariesState(ur, na);
}

class _CatogariesState extends State<Catogaries> {
  String url;
  String name;
  _CatogariesState(this.url, this.name);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowWallpaperCetogaries(name)));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        height: 100,
        width: width * 0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                fit: BoxFit.cover,
                image: NetworkImage(url))),
      ),
    );
  }
}
