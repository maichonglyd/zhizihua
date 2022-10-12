import 'package:fish_redux/fish_redux.dart';

class AccountRecycleSuccessState
    implements Cloneable<AccountRecycleSuccessState> {
  double amount;

  @override
  AccountRecycleSuccessState clone() {
    return AccountRecycleSuccessState()..amount = amount;
  }
}

AccountRecycleSuccessState initState(double amount) {
  return AccountRecycleSuccessState()..amount = amount;
}
