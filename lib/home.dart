import 'package:chains/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(child: Column()),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 60),
                child: PreferredSize(
                  preferredSize: Size.fromHeight(55),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: darkBlue,
                            width: 4,
                            style: BorderStyle.solid),
                        right: BorderSide(
                            color: darkBlue,
                            width: 4,
                            style: BorderStyle.solid),
                        left: BorderSide(
                            color: darkBlue,
                            width: 4,
                            style: BorderStyle.solid),
                      )),
                      padding: EdgeInsets.only(top: 4),
                      child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: pink, width: 4),
                              insets: EdgeInsets.fromLTRB(30, 0, 30, 75)),
                          labelColor: darkBlue,
                          labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.3),
                          unselectedLabelColor: Colors.grey,
                          tabs: <Widget>[
                            TabItem(
                              title: "Cycle",
                              icons: [Icons.album, Icons.adjust],
                              index: 0,
                              tabController: _tabController,
                            ),
                            TabItem(
                              title: "Stats",
                              icons: [Icons.menu, Icons.clear_all],
                              index: 1,
                              tabController: _tabController,
                            ),
                            TabItem(
                              title: "Chain",
                              icons: [Icons.hdr_strong, Icons.hdr_weak],
                              index: 2,
                              tabController: _tabController,
                            )
                          ])),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TabItem extends StatefulWidget {
  String title;
  List<IconData> icons;
  int index;
  TabController tabController;
  TabItem(
      {@required this.title,
      @required this.icons,
      @required this.index,
      @required this.tabController});

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabController.index;
    widget.tabController.addListener(() {
      setState(() {
        _currentIndex = widget.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: widget.title,
      icon: Icon(
          _currentIndex == widget.index ? widget.icons[0] : widget.icons[1],
          size: 30),
    );
  }
}
