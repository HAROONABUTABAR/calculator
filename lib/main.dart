import 'package:calculator_ui/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040D12),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: MyButton(
                        onTap: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        color: const Color(0xff93B1A6),
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      ),
                    );
                  } else if (index == 1) {
                    return Center(
                      child: MyButton(
                        onTap: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        color: const Color(0xff93B1A6),
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      ),
                    );
                  } else if (index == buttons.length - 1) {
                    return Center(
                      child: MyButton(
                        onTap: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        color: const Color(0xff183D3D),
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      ),
                    );
                  } else {
                    return Center(
                      child: MyButton(
                        color: const Color(0xff183D3D),
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        onTap: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                      ),
                    );
                  }
                },
                itemCount: buttons.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == "x" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String fianlQuestion = userQuestion;
    fianlQuestion = fianlQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(fianlQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
