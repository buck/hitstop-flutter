import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HITstop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HITstop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _delay = 5;
  int _maxtul = 150;
  int _countdown = 0;
  int _countup = 0;
  bool _running = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void start() {
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countup++;
        _countdown--;
      });
    });
  }

  void stop() {
    _timer.cancel();
    setState(() {
      _running = false;
    });
  }

  void reset() {
    if (_running) {
      _timer.cancel();
    }
    setState(() {
      _running = false;
      _countup = -_delay;
      _countdown = _delay + _maxtul;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '$_countup',
                  style: const TextStyle(fontSize: 1000),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        // padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: _running ? Colors.red : Colors.green,
                          border: Border.all(),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                _running ? stop() : start();
                              },
                              child: Text(
                                _running ? "Stop" : "Start",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                reset();
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), //Row
            ), //Expanded
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '$_countdown',
                  style: const TextStyle(fontSize: 1000),
                ), //Text
              ), //FittedBox
            ), //Expanded
          ],
        ),
      ),
    );
  }
}
