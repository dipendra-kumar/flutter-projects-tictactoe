import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool Oturn = true;

  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int xScore = 0;
  int oScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Player X", style: myTextStyle),
                      SizedBox(
                        height: 10,
                      ),
                      Text(xScore.toString(), style: myTextStyle),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Player O", style: myTextStyle),
                      SizedBox(
                        height: 10,
                      ),
                      Text(oScore.toString(), style: myTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("Reset Score",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  setState(() {
                    xScore = 0;
                    oScore = 0;
                  });
                },
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 50),
                child: Container(
            child: TextButton(onPressed: clearBoard, child: Text("Clear Board", style: myTextStyle,)

            ),
          ),
              )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (Oturn && displayXO[index] == '') {
        displayXO[index] = 'O';
      } else if (!Oturn && displayXO[index] == '') {
        displayXO[index] = 'X';
      }

      Oturn = !Oturn;
      checkWinner();
    });
  }

  void checkWinner() {
    //first row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      showWinDialog(displayXO[0]);
    }
    //2nd row
    else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      showWinDialog(displayXO[3]);
    }
    //3rd row
    else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      showWinDialog(displayXO[6]);
    }
    //1st column

    else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      showWinDialog(displayXO[0]);
    }
    //2nd Column
    else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      showWinDialog(displayXO[1]);
    }
    //3rd Column
    else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      showWinDialog(displayXO[2]);
    }
    // check diagonal
    else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      showWinDialog(displayXO[0]);
    }
    // check diagonal
    else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      showWinDialog(displayXO[2]);
    } else {
      showDraw();
    }
  }

  void showDraw() {}

  void showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
            
          return Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.grey[800]),
            child: AlertDialog(
              title: Text('$winner is Winner.', style: myTextStyle,),
              actions: <Widget>[
                TextButton(
                  child: Text("Play Again",style:TextStyle(color: Colors.white)),
                  onPressed: () {
                    clearBoard();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });

    if (winner == 'O') {
      oScore += 1;
    } else {
      xScore += 1;
    }
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
  }
}
