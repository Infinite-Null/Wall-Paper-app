import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("./assets/logo.png"))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: GradientText(
                    'Wall-Paper',
                    style: TextStyle(),
                    colors: [
                      Colors.amber,
                      Colors.red,
                      Color.fromARGB(255, 135, 92, 210),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      "provide free and high quality wallpapers. More than hundreds of thousands free high resolution Wallpapers are avaliable. ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Developed By : ",
                          style: TextStyle(color: Colors.white)),
                      GradientText(
                        'Ankit Kumar Shah',
                        style: TextStyle(),
                        colors: [
                          Colors.lightBlue,
                          Colors.lightGreen,
                          Colors.limeAccent,
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("./assets/me.jpg"))),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Github : ", style: TextStyle(color: Colors.white)),
                      GradientText(
                        'Infinite-Null',
                        style: TextStyle(),
                        colors: [
                          Colors.lightBlue,
                          Colors.lightGreen,
                          Colors.limeAccent,
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("./assets/github.jpg"))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
