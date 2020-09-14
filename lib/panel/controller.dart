import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:TetRiX/gamer/gamer.dart';
import 'package:TetRiX/generated/i18n.dart';

class GameController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: <Widget>[
          Stack(children: <Widget>[LeftController()]),
          Stack(children: <Widget>[DirectionController()]),
          Stack(children: <Widget>[Down()]),
        ],
      ),
    );
  }
}

const Size _DIRECTION_BUTTON_SIZE = const Size(39, 20);
const double _DIRECTION_SPACE = 1;

class DirectionController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      height: 240,
      width: 240,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/controller.png'),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox.fromSize(size: _DIRECTION_BUTTON_SIZE * 0.75),
              Transform.scale(
                scale: 0.8,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: _DIRECTION_SPACE),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              iconSize: 75,
                              color: Colors.blue.withOpacity(0),
                              onPressed: () {
                                Game.of(context).rotate();
                              }),
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              iconSize: 75,
                              color: Colors.blue.withOpacity(0),
                              onPressed: () {
                                Game.of(context).right();
                              }),
                          SizedBox(width: _DIRECTION_SPACE),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              iconSize: 75,
                              color: Colors.blue.withOpacity(0),
                              onPressed: () {
                                Game.of(context).left();
                              }),
                          SizedBox(width: _DIRECTION_SPACE),
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              iconSize: 75,
                              color: Colors.blue.withOpacity(0),
                              onPressed: () {
                                Game.of(context).down();
                              }),
                          SizedBox(width: _DIRECTION_SPACE),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SystemButtonGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 40,
            child: FloatingActionButton(
                onPressed: () {
                  Game.of(context).soundSwitch();
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Image.asset('assets/images/volume_icon.png'),
                )),
          ),
          SizedBox(
            height: 40,
            child: FloatingActionButton(
                onPressed: () {
                  Game.of(context).pauseOrResume();
                },
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Image.asset('assets/images/play_icon.png'))),
          ),
          SizedBox(
            height: 40,
            child: FloatingActionButton(
                onPressed: () {
                  Game.of(context).reset();
                },
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Image.asset('assets/images/replay_icon.png'))),
          ),
        ],
      ),
    );
  }
}

class Down extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 93, bottom: 10),
      alignment: Alignment.centerLeft,
      child: IconButton(
          icon: Icon(Icons.add_circle),
          iconSize: 60,
          color: Colors.blue.withOpacity(0),
          onPressed: () {
            Game.of(context).drop();
          }),
    );
  }
}

class Lines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 250),
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        image: DecorationImage(
            scale: 2.5, image: AssetImage('assets/images/lines.png')),
      ),
    );
  }
}

class LeftController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SystemButtonGroup(),
        Spacer(),
        Expanded(
          child: Center(
            child: Lines(),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatefulWidget {
  final Size size;
  final Widget icon;

  final VoidCallback onTap;

  ///the color of button
  final Color color;

  final bool enableLongPress;

  const _Button(
      {Key key,
      @required this.size,
      @required this.onTap,
      this.icon,
      this.color = Colors.blue,
      this.enableLongPress = true})
      : super(key: key);

  @override
  _ButtonState createState() {
    return new _ButtonState();
  }
}

///show a hint text for child widget
class _Description extends StatelessWidget {
  final String text;

  final Widget child;

  final AxisDirection direction;

  const _Description({
    Key key,
    this.text,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(direction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (direction) {
      case AxisDirection.right:
        widget = Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[child, SizedBox(width: 8), Text(text)]);
        break;
      case AxisDirection.left:
        widget = Row(
          children: <Widget>[Text(text), SizedBox(width: 8), child],
          mainAxisSize: MainAxisSize.min,
        );
        break;
      case AxisDirection.up:
        widget = Column(
          children: <Widget>[Text(text), SizedBox(height: 8), child],
          mainAxisSize: MainAxisSize.min,
        );
        break;
      case AxisDirection.down:
        widget = Column(
          children: <Widget>[child, SizedBox(height: 8), Text(text)],
          mainAxisSize: MainAxisSize.min,
        );
        break;
    }
    return DefaultTextStyle(
      child: widget,
      style: TextStyle(fontSize: 12, color: Colors.black),
    );
  }
}

class _ButtonState extends State<_Button> {
  Timer _timer;

  bool _tapEnded = false;

  Color _color;

  @override
  void didUpdateWidget(_Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    _color = widget.color;
  }

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _color,
      elevation: 2,
      shape: CircleBorder(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) async {
          setState(() {
            _color = widget.color.withOpacity(0.5);
          });
          if (_timer != null) {
            return;
          }
          _tapEnded = false;
          widget.onTap();
          if (!widget.enableLongPress) {
            return;
          }
          await Future.delayed(const Duration(milliseconds: 300));
          if (_tapEnded) {
            return;
          }
          _timer = Timer.periodic(const Duration(milliseconds: 60), (t) {
            if (!_tapEnded) {
              widget.onTap();
            } else {
              t.cancel();
              _timer = null;
            }
          });
        },
        onTapCancel: () {
          _tapEnded = true;
          _timer?.cancel();
          _timer = null;
          setState(() {
            _color = widget.color;
          });
        },
        onTapUp: (_) {
          _tapEnded = true;
          _timer?.cancel();
          _timer = null;
          setState(() {
            _color = widget.color;
          });
        },
        child: SizedBox.fromSize(
          size: widget.size,
        ),
      ),
    );
  }
}
