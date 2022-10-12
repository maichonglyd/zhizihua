import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';

class StarWidget extends StatelessWidget {
  int starNum = 0;
  List<int> list = List.generate(5, (index) => index);

  StarWidget(
    this.starNum, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(list);
    return Container(
      child:
//        Row(children: <Widget>[
//          Icon(Icons.star,size: 12,),
//          Icon(Icons.star,size: 12,),
//          Icon(Icons.star,size: 12,),
//          Icon(Icons.star,size: 12,),
//          Icon(Icons.star,size: 12,),
//        ],
//
//        )
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list.asMap().keys.map((index) {
          if (index >= starNum) {
            return Icon(
              Icons.star,
              size: 12,
              color: Color(0xFFCCCCCC),
            );
          }
          return Icon(
            Icons.star,
            size: 12,
            color: Color(0xFFFFBC03),
          );
        }).toList(),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  List<int> scores = List();
  CommentWidget(CommentStar starCnt) {
    scores.add(starCnt.star1);
    scores.add(starCnt.star2);
    scores.add(starCnt.star3);
    scores.add(starCnt.star4);
    scores.add(starCnt.star5);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: scores
              .asMap()
              .keys
              .map((index) => Row(
                    children: <Widget>[
                      Text((index + 1).toString()),
                      Icon(
                        Icons.star_border,
                        size: 12,
                      ),
                      Container(
                        height: 6,
                        width: 150.0 / 100.0 * scores[index],
                        color: Color(0xFF008FFF),
                      )
                    ],
                  ))
              .toList()),
    );
  }
}
