import 'package:chains/colors.dart';
import 'package:chains/main.dart';
import 'package:chains/service/cycleService.dart';
import 'package:flutter/material.dart';

class Cycle extends StatefulWidget {
  @override
  _CycleState createState() => _CycleState();
}

class _CycleState extends State<Cycle> {
  @override
  void initState() {
    super.initState();
    cycleService = cycleController.get<CycleService>();
  }

  CycleService cycleService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                        child: Center(
                            child: Text("CYCLE",
                                style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 25,
                                    fontFamily: 'Arya',
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3)))),
                  ],
                ),
                Divider(height: 45.0, color: Colors.black),
                StreamBuilder(
                    stream: cycleService.isCycling$,
                    builder: (context, snapshot) {
                        return Center(
                            child: Column(
                          children: <Widget>[
                            Text("coutdown started: ${snapshot.data}"),
                            snapshot.data == true
                                ? Text('duration: ${cycleService.duration}')
                                : SizedBox()
                          ],
                        ));
                    }),
                Divider(height: 45.0, color: Colors.black),
                StreamBuilder(
                    stream: cycleService.elapsedTime$,
                    builder: (context, snapshot) {
                      return Center(
                        child:
                            Text("${cycleService.elapsedTime} seconds passed."),
                      );
                    }),
                Divider(height: 45.0, color: Colors.black),
                CycleController(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        cycleService.startCycle();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFff6e6e),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("Start Cycle.",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cycleService.endCycle();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF00a572),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("End Cycle.",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CycleController extends StatelessWidget {
  final CycleService cycleService = cycleController.get<CycleService>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            cycleService.increaseDuration();
          },
          child: Icon(
            Icons.arrow_upward,
            color: Colors.green,
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: cycleService.duration$,
                  builder: (context, snapshot) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Cycle Time",
                                style: TextStyle(
                                  fontFamily: "Poiret",
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ))),
                        Text("${cycleService.duration}",
                            style: TextStyle(
                              fontFamily: "Poiret",
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            )),
                      ],
                    );
                  }),
              SizedBox(height: 10),
              Text("Build chain for ${cycleService.duration} minutes?",
                  style: TextStyle(
                    fontFamily: "Poiret",
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              Divider()
            ],
          ),
        ),
        SizedBox(width: 25),
        GestureDetector(
          onTap: () {
            cycleService.decreaseDuration();
          },
          child: Icon(
            Icons.arrow_downward,
            color: Colors.pink,
          ),
        )
      ],
    );
  }
}
