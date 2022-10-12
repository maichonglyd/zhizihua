import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'action.dart';
import 'state.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

Widget buildView(
    IndexViewPagerState state, Dispatch dispatch, ViewService viewService) {
  const List<Choice> choices = const <Choice>[
    const Choice(title: 'CAR', icon: Icons.directions_car),
    const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
    const Choice(title: 'BOAT', icon: Icons.directions_boat),
    const Choice(title: 'BUS', icon: Icons.directions_bus),
    const Choice(title: 'TRAIN', icon: Icons.directions_railway),
    const Choice(title: 'WALK', icon: Icons.directions_walk),
  ];

  return new Scaffold(
    appBar: new AppBar(
      title: const Text('Tabbed AppBar'),
      bottom: new TabBar(
        isScrollable: true,
        tabs: choices.map((Choice choice) {
          return new Tab(
            text: choice.title,
            icon: new Icon(choice.icon),
          );
        }).toList(),
      ),
    ),
    body: new TabBarView(
      children: choices.map((Choice choice) {
        return new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ChoiceCard(choice: choice),
        );
      }).toList(),
    ),
  );
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
