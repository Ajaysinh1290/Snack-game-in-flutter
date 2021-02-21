import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:snack_game/my_painter.dart';
import 'utils/utils.dart';
class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isStopped = true;
  bool left = false;
  bool right = true;
  bool up = false;
  bool down = false;
  bool isVariableInit = false;
  int drawNewAggTime = 0;
  int snackHeadX = 0;
  int snackHeadY = 0;
  int move = 20;
  double width = 0;
  double height = 0;
  int score = 0;
  double bottomContainerHeight=150;
  double topContainerHeight=50;
  double controlSize = 45;
  int newAggDelayTime = 3;

  List<double> xPoints = List();
  List<double> yPoints = List();
  AnimationController _animationController;
  Offset eggLocation;
  Queue<Offset> snackLocations=Queue();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newAggDelayTime=SnackUtils.drawNewAggTime;
    move=SnackUtils.snackRectSize;
    snackLocations.add(Offset(snackHeadX.toDouble(),snackHeadY.toDouble()));

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationController.forward();

    Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
        moveSnack();
      });
    });


  }
  Future<AudioPlayer> playSound() async {
    AudioCache cache = new AudioCache();
    return await cache.play("hat.mp3");
    // AssetsAudioPlayer.newPlayer().open(
    //   Audio("assets/audios/song1.mp3"),
    //   autoPlay: true,
    //   showNotification: true,
    // );

  }
  moveSnack() {

    if (isStopped) {
      return;
    }

    //Moving Agg according to direction
    if (up) {
      snackHeadY = snackHeadY <= yPoints[0].round()
          ? yPoints[yPoints.length - 1].round()
          : snackHeadY - move;
    } else if (down) {
      snackHeadY = snackHeadY >= yPoints[yPoints.length - 1].round()
          ? yPoints[0].round()
          : snackHeadY + move;
    } else if (left) {
      snackHeadX = snackHeadX <= xPoints[0].round()
          ? xPoints[xPoints.length - 1].round()
          : snackHeadX - move;
    } else if (right) {
      snackHeadX = snackHeadX >= xPoints[xPoints.length - 1].round()
          ? xPoints[0].round()
          : snackHeadX + move;
    }
    Offset head=Offset(snackHeadX.toDouble(), snackHeadY.toDouble());
    if(snackLocations.contains(head)){
      setState(() {
        isStopped=true;
      });
      showGameOverDialog(context);

      return;
    }
    snackLocations.add(head);

    //Checking Agg location with snack head
    if (snackHeadX ==eggLocation.dx && snackHeadY ==eggLocation.dy) {
      playSound();
      eggLocation = Offset(-50, -50);
      score++;
      drawNewAggTime = newAggDelayTime;
    } else {
      snackLocations.removeFirst();
    }
  }

  drawNewAgg() {
    // generating random x and y offset for new agg location from xPoints and yPoints list
   eggLocation = Offset(xPoints[Random().nextInt(xPoints.length - 1)],
        yPoints[Random().nextInt(yPoints.length - 1)]);

    //If new agg location is over lapping snack locations then we're recalling function for new egg locations
    if(snackLocations.contains(eggLocation)) {
      drawNewAgg();
    }
  }

  initVariables() {

    for (double y = 0;
        y < height - topContainerHeight-bottomContainerHeight - MediaQuery.of(context).padding.top;
        y += SnackUtils.snackRectSize) {
      yPoints.add(y);
    }
    for (double x = 0; x < width; x += SnackUtils.snackRectSize) {
      xPoints.add(x);
    }
    //Removing points which are out of the box
        xPoints.removeLast();
        yPoints.removeLast();

    drawNewAgg();
  }

  checkNewAggTime() {
    if (drawNewAggTime > 0) {
      drawNewAggTime--;
      if (drawNewAggTime == 0) {
        drawNewAgg();
      }
    }
  }

  moveLeft() {
    if (isStopped) {
      return;
    }
    if(right&&snackLocations.length>1) {
      snackHeadY+=move;
      if(!yPoints.contains(snackHeadY)) {
        snackHeadY-=2*move;
      }
      snackLocations.add(Offset(snackHeadX.toDouble(), snackHeadY.toDouble()));
      snackLocations.removeFirst();
    }
    down = false;
    up = false;
    left = true;
    right = false;
  }
  moveRight() {
    if (isStopped) {
      return;
    }
    if(left&&snackLocations.length>1) {
      snackHeadY-=move;
      if(!yPoints.contains(snackHeadY)) {
        snackHeadY+=2*move;
      }
      snackLocations.add(Offset(snackHeadX.toDouble(), snackHeadY.toDouble()));
      snackLocations.removeFirst();
    }
    down = false;
    up = false;
    left = false;
    right = true;
  }
  moveUp() {
    if (isStopped) {
      return;
    }
    if(down&&snackLocations.length>1) {
      snackHeadX-=move;
      if(!xPoints.contains(snackHeadX)) {
        snackHeadX+=2*move;
      }
      snackLocations.add(Offset(snackHeadX.toDouble(), snackHeadY.toDouble()));
      snackLocations.removeFirst();
    }
    down = false;
    up = true;
    left = false;
    right = false;
  }
  moveDown() {
    if (isStopped) {
      return;
    }
    if(up&&snackLocations.length>1) {
      snackHeadX+=move;
      if(!xPoints.contains(snackHeadX)) {
        snackHeadX-=2*move;
      }
      snackLocations.add(Offset(snackHeadX.toDouble(), snackHeadY.toDouble()));
      snackLocations.removeFirst();
    }
    down = true;
    up = false;
    left = false;
    right = false;
  }

  showGameOverDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,

      context: context,
      builder: (context){
        return AlertDialog(
          elevation: 0,
          title: Text('Game Over',style: TextStyle(fontSize: 30),),
          actions: [
            RaisedButton(
              color: Colors.yellow,
              onPressed: (){
                snackLocations.clear();
                snackHeadX=0;
                snackHeadY=0;
                snackLocations.add(Offset(snackHeadX.toDouble(),snackHeadY.toDouble()));
                score=0;
                isStopped=false;
                drawNewAgg();
                Navigator.pop(context);
              },
              child: Text(
                'Ok'
              ),
            )
          ],
        );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    checkNewAggTime();
    if (!isVariableInit) {
      initVariables();
      isVariableInit = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: topContainerHeight,
              decoration: BoxDecoration(
                  color: ColorPallette.controlContainerColor,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey[800], width: 2))),
              child: Text(
                "Score : " + score.toString(),
                style: TextStyle(color:  ColorPallette.controlColor, fontSize: 30),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:  ColorPallette.canvasColor,
                  boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1,1)

                  ),
                ],
              ),
              child: CustomPaint(
                size: Size(
                    xPoints.length*SnackUtils.snackRectSize.toDouble(), yPoints.length*SnackUtils.snackRectSize.toDouble()),
                painter: MyPainter(snackLocations,eggLocation),
                willChange: true,
                isComplex: true,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: bottomContainerHeight,

              decoration: BoxDecoration(
                color:  ColorPallette.controlContainerColor,
                border:
                    Border(top: BorderSide(color: Colors.grey[800], width: 2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: controlSize,
                      color:  ColorPallette.controlColor,
                    ),
                    onPressed: () {
                      setState(() {
                        moveUp();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Icon(
                          Icons.arrow_left,
                          size: controlSize,
                          color:  ColorPallette.controlColor,
                        ),
                        onPressed: () {
                          setState(() {
                            moveLeft();
                          });
                        },
                      ),
                      FlatButton(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          size: 40,
                          color: ColorPallette.controlColor,
                          progress: _animationController,
                        ),
                        onPressed: () {
                          isStopped = !isStopped;
                          isStopped?_animationController.forward():_animationController.reverse();
                        },

                      ),
                      // FlatButton(
                      //   child: Icon(
                      //     isStopped
                      //         ? Icons.play_circle_fill
                      //         : Icons.pause_circle_filled,
                      //     size: controlSize + 5,
                      //     color:  ColorPallette.controlColor,
                      //   ),
                      //   onPressed: () {
                      //     isStopped = !isStopped;
                      //   },
                      // ),
                      FlatButton(
                        child: Icon(
                          Icons.arrow_right,
                          size: controlSize,
                          color:  ColorPallette.controlColor,
                        ),
                        onPressed: () {
                          setState(() {
                          moveRight();
                          });
                        },
                      ),
                    ],
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: controlSize,
                      color:  ColorPallette.controlColor,
                    ),
                    onPressed: () {
                      setState(() {
                       moveDown();
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
