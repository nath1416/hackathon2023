import 'package:flutter/material.dart';

typedef ss = void Function(bool, String);

class MainDrawer extends StatefulWidget {
  final ss toggleSwitch;
  final Map<String, bool> currentFilters;

  MainDrawer(
      {super.key, required this.toggleSwitch, required this.currentFilters});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleSwitch(bool value, String title) {
    title = title.toLowerCase();
    setState(() {
      widget.currentFilters[title] = value;
    });
    widget.toggleSwitch(value, title);
  }

  Widget buildListTile(String title, IconData icon, ss toggleSwitch) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Transform.scale(
          scale: 2,
          child: Switch(
            onChanged: (value) => _toggleSwitch(value, title),
            value: widget.currentFilters[title.toLowerCase()] as bool,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        alignment: AlignmentDirectional.center,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Filters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Admiration",
                  Icons.person,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Amusement",
                  Icons.sports_gymnastics_outlined,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Approval",
                  Icons.thumb_up,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Caring",
                  Icons.label_important_outlined,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Love",
                  Icons.handshake,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Optimism",
                  Icons.sentiment_satisfied_outlined,
                  widget.toggleSwitch,
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile(
                  "Relief",
                  Icons.done_all_sharp,
                  widget.toggleSwitch,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
