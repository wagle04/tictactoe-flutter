import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/configs/themeSwitcher.dart';
import 'package:tictactoe/logic/logic.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeSwitcher(),
        child: TicTacToeApp(),
      ),
    );

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeSwitcher>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: ChangeNotifierProvider(
        child: MainApp(),
        create: (context) => TicTacToe(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeSwitcher>(context);
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    final tictactoe = Provider.of<TicTacToe>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tic Tac Toe",
            style: Theme.of(context).textTheme.title,
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                theme.changeTheme();
              },
              child: Container(
                height: 50,
                width: 75,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: FlareActor(
                    'assets/flareassets/switch_daytime.flr',
                    fit: BoxFit.contain,
                    animation: theme.isLightTheme() ? 'day_idle' : 'night_idle',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(tictactoe.getTurnString().toString()),
            Center(
              child: Container(
                height: width * 0.9,
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(9, (i) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleBox(
                        isLightTheme: theme.isLightTheme(),
                        width: width,
                        value: tictactoe.matrixInfo(i),
                        onPressed: () {
                          if (!tictactoe.gameFinished()) {
                            tictactoe.updateMatrix(i);
                          } else {
                            print("game over");
                          }
                          setState(() {});
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            Text(tictactoe.getWinnerString().toString()),
            RaisedButton(
              child: Text("New Game"),
              onPressed: () {
                //TODO reset game to new game
                tictactoe.newGame();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SingleBox extends StatefulWidget {
  final width;
  final isLightTheme;
  final onPressed;
  final value;

  const SingleBox(
      {Key key, this.width, this.isLightTheme, this.onPressed, this.value})
      : super(key: key);

  @override
  _SingleBoxState createState() => _SingleBoxState();
}

class _SingleBoxState extends State<SingleBox> {
  Widget circle = Icon(
    FontAwesomeIcons.circle,
    color: Colors.red,
  );
  Widget cross = Icon(
    FontAwesomeIcons.times,
    color: Colors.blue,
  );
  Widget child = Container();

  @override
  Widget build(BuildContext context) {
    if (widget.value == 0) {
      child = cross;
    } else if (widget.value == 1) {
      child = circle;
    }

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width * 0.25,
        height: widget.width * 0.25,
        decoration: BoxDecoration(
          color: widget.isLightTheme ? Colors.black54 : Colors.white30,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FittedBox(
            fit: BoxFit.fill,
            child: child,
          ),
        ),
      ),
    );
  }
}
