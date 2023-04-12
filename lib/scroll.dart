

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyLiquidSwipe extends StatelessWidget {
  final pages = [
    Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned(
            top: 20, // Update the top offset using MediaQuery
            left: 85, // Update the left offset using MediaQuery
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'Assets/image/signup.svg', // Replace with your SVG image asset path
                  height: 250,
                  width: 200,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    ),

    // Rest of the pages...

    Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Page 2',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    ),
    Container(
      color: Colors.orange,
      child: Center(
        child: Text(
          'Page 3',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 500,
        slideIconWidget: Icon(Icons.arrow_back_ios),
        positionSlideIcon: 0.8,
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height * 0.002, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
