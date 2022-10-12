import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';

class ServerPopupRoute extends PopupRoute {
  ServerPopupRoute(
      this.barrierLabel, this.server, this.anchorKey, this.selectServer);

  Function(Service service) selectServer;

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  List<Service> server;

  GlobalKey anchorKey;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: DownSingleChildLayoutDelegate(anchorKey),
            child: Material(
              child: Container(
                height: 228,
                width: 360,
                color: Colors.white,
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    children: server
                        .map((server) => buildItem(context, server))
                        .toList()),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, Service service) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        selectServer(service);
//        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.all(7),
        alignment: Alignment.center,
        height: 31,
        width: 159,
        child: Text(
          service.serverName,
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor),
        ),
        color: Color(0xFFEDEDED),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(seconds: 10);
}

class DownSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  GlobalKey anchorKey;

  DownSingleChildLayoutDelegate(this.anchorKey);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(maxHeight: 228, minHeight: 228);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));

    return Offset(0, offset.dy);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return true;
  }
}
