import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StackHeadWidget extends StatelessWidget {
  List<String> urls;

  StackHeadWidget(this.urls);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: urls.asMap().keys.map((index) {
        double margin = index * 21.0;
        return Container(
          height: 26,
          width: 26,
          margin: EdgeInsets.only(left: margin),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(urls[index]),
            ),
          ),
        );
      }).toList(),
    );
  }
}
