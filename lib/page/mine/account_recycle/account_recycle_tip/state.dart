import 'package:fish_redux/fish_redux.dart';

class AccountRecycleTipState implements Cloneable<AccountRecycleTipState> {
  @override
  AccountRecycleTipState clone() {
    return AccountRecycleTipState();
  }
}

AccountRecycleTipState initState(Map<String, dynamic> args) {
  return AccountRecycleTipState();
}
