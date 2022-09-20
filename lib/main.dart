import 'package:flutter/material.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required this.title});
  @override
_MyHomePageState createState()=> _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int seconds=0,minutes=0,hours=0;
String digitSeconds="00",digitMinutes="00",digitHours="00";
Timer ?timer;
bool started=false;
List laps=[];

void stop(){
  timer!.cancel();
  setState(() {
    started=false;
  });
}
void reset(){
  timer!.cancel();
  setState(() {
    seconds=0;
    minutes=0;
    hours=0;

    digitHours="00";
    digitMinutes="00";
    digitSeconds="00";

    started=false;
  });
}
void addLaps(){
  String lap="$digitMinutes:$digitMinutes:$digitSeconds";
  setState(() {
    laps.add(lap);
  });
}
void start(){
  started=true;
  timer=Timer.periodic(Duration(seconds: 1),(timer){
    int localSeconds = seconds+1;
    int localMinutes=minutes;
    int localHours=hours;

    if(localSeconds>59){
      if(localMinutes>59){
        localHours++;
        localMinutes=0;
        localSeconds=0;
      }
      else{
        localMinutes++;
        localSeconds=0;
      }
    }
    setState(() {
      seconds=localSeconds;
      minutes=localMinutes;
      hours=localHours;
      digitSeconds=(seconds>=10)? "$seconds":"0$seconds";
      digitMinutes=(minutes>=10)? "$minutes":"0$minutes";
      digitHours=(hours>=10)? "$hours":"0$hours";
    });
  });
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0XFF1C2757),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text("StopWatch App",
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              SizedBox(
                height:20,
              ),
                Center(
                  child:Text("$digitHours:$digitMinutes:$digitSeconds",style: TextStyle(
                    color: Colors.white,
                    fontSize: 82,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                Container(
                  height: 400,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(10),
                ),
                    child:ListView.builder(itemCount: laps.length,
                    itemBuilder: (context,index){
                      return Padding(padding: const EdgeInsets.all(16),child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n${index+1}",
                            style: TextStyle(
                          color:Colors.white,
                        fontSize:16,
                      ),

                          ),
                      Text(
                      "${laps[index]}",
                      style:TextStyle(
                      color: Colors.white,
                      fontSize:16,
                      ),
                      ),
                        ],
                      ),
                      );
                    },)
                ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: RawMaterialButton(
                    onPressed: (){(!started)?start():stop();},
                      fillColor: Colors.white,
                    shape:
                    const StadiumBorder(
                        side: BorderSide(color: Colors.blue)
                    ),
                    child: Text((!started)?"Start":"Pause",
                      style:TextStyle(color: Colors.blue),
                    )
                  ),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: (){addLaps();},
                    icon: Icon(Icons.flag),),
                  Expanded(child: RawMaterialButton(
                      onPressed: (){
                        reset();
                      },
                      fillColor: Colors.white,
                      shape:
                      const StadiumBorder(
                          side: BorderSide(color: Colors.blue)
                      ),
                      child: Text("Reset",
                        style:TextStyle(color: Colors.blue,
                          fontWeight: FontWeight.bold,),
                      )
                  ),
                  ),
                  SizedBox(width:8.0,),

                ],
              )
        ],
          ),
        )
      ),
    );
  }
}