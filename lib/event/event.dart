class Event {
  int index;
  String tag;
  bool switchBol;
//  List<String> barrages;
  Event(this.tag, {this.switchBol, this.index});
}

class RefreshH5Event {
  String tag;
  bool refresh;

  RefreshH5Event(this.tag, {this.refresh = false});
}