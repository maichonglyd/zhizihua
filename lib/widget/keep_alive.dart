import 'package:flutter/material.dart' hide Action;

class KeepAliveWidget extends StatefulWidget {
  final Widget child;

  const KeepAliveWidget(this.child);

  @override
  State<StatefulWidget> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

Widget keepAliveWrapper(Widget child) => KeepAliveWidget(child);
