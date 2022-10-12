import 'package:fish_redux/fish_redux.dart';

class PaySuccessState implements Cloneable<PaySuccessState> {
  @override
  PaySuccessState clone() {
    return PaySuccessState();
  }
}

PaySuccessState initState(Map<String, dynamic> args) {
  return PaySuccessState();
}
