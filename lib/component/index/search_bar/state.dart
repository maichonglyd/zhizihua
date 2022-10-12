import 'package:flutter_huoshu_app/global_store/state.dart';

class SearchBarState with GlobalBaseState<SearchBarState> {
  bool enableEdit = true;
  String hint;
  String msgCount = "…";

  @override
  SearchBarState clone() {
    return new SearchBarState()
      ..copyGlobalFrom(this)
      ..enableEdit = enableEdit
      ..hint = hint
      ..msgCount = msgCount;
  }
}

SearchBarState initState(String hint, bool enableEdit) {
  //just demo, do nothing here...
  return SearchBarState()
    ..enableEdit = enableEdit
    ..hint = hint;
}
