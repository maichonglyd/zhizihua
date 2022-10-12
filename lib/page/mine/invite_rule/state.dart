import 'package:fish_redux/fish_redux.dart';

class InviteRuleState implements Cloneable<InviteRuleState> {
  String rule;
  @override
  InviteRuleState clone() {
    return InviteRuleState()..rule = rule;
  }
}

InviteRuleState initState(String rule) {
  return InviteRuleState()..rule = rule;
}
