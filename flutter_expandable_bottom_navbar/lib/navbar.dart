import 'dart:ui';

import 'package:flutter/material.dart';

const _cardColor = Color(0XFF5F40F8);
const _maxHeight = 350.0;
const _minHeight = 70.0;

class HoempageWithExpandableNav extends StatefulWidget {
  const HoempageWithExpandableNav({Key? key}) : super(key: key);

  @override
  _HoempageWithExpandableNavState createState() =>
      _HoempageWithExpandableNavState();
}

class _HoempageWithExpandableNavState extends State<HoempageWithExpandableNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;
  double _currentHeight = _minHeight;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuWidth = size.width * 0.4;

    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: GestureDetector(
        onVerticalDragUpdate: _expanded
            ? (details) {
                print(details);
                setState(() {
                  // _expanded = !_expanded;
                  final newHeight = _currentHeight + details.delta.dy;
                  _controller.value = _currentHeight / _maxHeight;
                  _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                });

                // if (_expanded)
                //   _controller.forward();
                // else
                //   _controller.reverse();
              }
            : null,
        onVerticalDragEnd: _expanded
            ? (details) {
                if (_currentHeight < _maxHeight / 2) {
                  _controller.reverse();
                  _expanded = false;
                } else {
                  _expanded = true;
                  _controller.forward(from: _currentHeight / _maxHeight);
                  _currentHeight = _maxHeight;
                }
              }
            : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _controller.value;
            return Stack(
              children: [
                Positioned(
                  height: lerpDouble(
                    _minHeight,
                    _maxHeight,
                    value,
                  ),
                  left: lerpDouble(
                    size.width / 2 - menuWidth / 2,
                    0,
                    value,
                  ),
                  width: lerpDouble(
                    menuWidth,
                    size.width,
                    value,
                  ),
                  bottom: lerpDouble(
                    40,
                    0,
                    value,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          20,
                        ),
                        bottom: Radius.circular(
                          lerpDouble(
                                20,
                                0,
                                value,
                              ) ??
                              0,
                        ),
                      ),
                      color: _cardColor,
                    ),
                    child:
                        _expanded ? _buildExpandableNav() : _buildMenuContent(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandableNav() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 15),
          Text(
            'Blood Tear',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.shuffle),
            Icon(Icons.pause),
            Icon(Icons.playlist_add),
          ])
        ],
      ),
    );
  }

  Widget _buildMenuContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.calendar_today_sharp),
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = true;
              _currentHeight = _maxHeight;
              _controller.forward(from: 0);
            });
          },
          child: Icon(
            Icons.calendar_today,
          ),
        ),
        Icon(Icons.calendar_today_sharp),
      ],
    );
  }
}
