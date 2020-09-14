import 'package:flutter/material.dart';
import 'package:TetRiX/generated/i18n.dart';
import 'package:TetRiX/main.dart';
import 'package:TetRiX/panel/controller.dart';
import 'package:TetRiX/panel/screen.dart';

part 'page_land.dart';

class PagePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = MediaQuery.of(context).size.width * 0.8;

    return SizedBox.expand(
      child: Container(
        color: BACKGROUND_COLOR,
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/top.png'),
              Row(
                children: <Widget>[
                  Spacer(),
                ],
              ),
              Spacer(),
              _ScreenDecoration(child: Screen(width: screenW)),
              Spacer(flex: 1),
              GameController(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenDecoration extends StatelessWidget {
  final Widget child;

  const _ScreenDecoration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: SCREEN_BORDER_WIDTH),
          left: BorderSide(color: Colors.black, width: SCREEN_BORDER_WIDTH),
          right: BorderSide(color: Colors.black, width: SCREEN_BORDER_WIDTH),
          bottom: BorderSide(color: Colors.black, width: SCREEN_BORDER_WIDTH),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: Container(
          padding: const EdgeInsets.all(3),
          color: SCREEN_BACKGROUND,
          child: child,
        ),
      ),
    );
  }
}
