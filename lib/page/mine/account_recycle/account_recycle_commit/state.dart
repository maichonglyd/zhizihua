import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

class AccountRecycleCommitState
    implements Cloneable<AccountRecycleCommitState> {
  RecycleMg recycleMg;

  @override
  AccountRecycleCommitState clone() {
    return AccountRecycleCommitState()..recycleMg = recycleMg;
  }
}

AccountRecycleCommitState initState(RecycleMg recycleMg) {
  return AccountRecycleCommitState()..recycleMg = recycleMg;
}
