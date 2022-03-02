import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }


  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //creating the start timing function
  void start(){
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59){
        if (localMinutes > 59){
          localHours++;
          localMinutes = 0;
        }else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Center(
                child: Text(
                  "StopWatch App",
                  style: TextStyle(color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0,),
               Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize:82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // now lets add a list builder
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context , index){
                      return Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap N${index + 1}", style: const TextStyle(
                              color: Colors.white,
                          fontSize: 16.0
                          ),),
                          Text("${laps[index]}", style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),),
                        ],
                      ),);
                    }),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                      fillColor: Colors.deepOrange,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.blue,
                      )
                    ),
                      child: Text((!started) ? "Start" : "Pause",style: const TextStyle(color: Colors.white,),
                      ),
                  ),
                  ),
                  const SizedBox(width: 8.0,),
                  IconButton(
                    color: Colors.white,
                      onPressed: (){
                        addLaps();
                      }, icon: const Icon(Icons.flag),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                          side: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      child: const Text("Reset",style: TextStyle(color: Colors.white,),
                      ),
                    ),
                  ),
                ],

              )
            ],
          ),
        ),
      ),
    );
  }
}
