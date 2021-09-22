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

class _HoempageWithExpandableNavState extends State<HoempageWithExpandableNav> {
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
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            height: _maxHeight,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    20,
                  ),
                ),
                color: _cardColor,
              ),
              child: _buildExpandableNav(),
            ),
          ),
          Positioned(
            height: _minHeight,
            left: size.width / 2 - menuWidth / 2,
            bottom: 40,
            width: menuWidth,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    20,
                  ),
                  bottom: Radius.circular(
                    20,
                  ),
                ),
                color: Colors.red,
              ),
              child: _buildMenuContent(),
            ),
          )
        ],
      ),
    );
  }
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
      Icon(Icons.calendar_today),
      Icon(Icons.calendar_today_sharp),
    ],
  );
}
