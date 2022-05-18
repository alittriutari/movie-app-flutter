import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final double height, width;
  const PlaceholderWidget({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          'assets/loading.gif',
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
