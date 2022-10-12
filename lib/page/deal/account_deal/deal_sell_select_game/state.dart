import 'package:fish_redux/fish_redux.dart';

class DealSellSelectGameState implements Cloneable<DealSellSelectGameState> {
  @override
  DealSellSelectGameState clone() {
    return DealSellSelectGameState();
  }
}

DealSellSelectGameState initState(Map<String, dynamic> args) {
  return DealSellSelectGameState();
}
