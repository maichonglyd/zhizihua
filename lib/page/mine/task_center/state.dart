import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

class TaskCenterState implements Cloneable<TaskCenterState> {
  TaskHome taskHome;
  UserInfo userInfo;
  List<Item> tabs;

  @override
  TaskCenterState clone() {
    return TaskCenterState()
      ..taskHome = taskHome
      ..tabs = tabs
      ..userInfo = userInfo;
  }
}

TaskCenterState initState(Map<String, dynamic> args) {
  return TaskCenterState();
}
