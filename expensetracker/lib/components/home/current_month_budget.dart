import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CurrentMonthBudget extends StatefulWidget {
  const CurrentMonthBudget({Key? key}) : super(key: key);

  @override
  _CurrentMonthBudgetState createState() => _CurrentMonthBudgetState();
}

class _CurrentMonthBudgetState extends State<CurrentMonthBudget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Left to Spend',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Monthly Budget',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '\$24900',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '\$300009',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.6,
                  backgroundColor: Colors.amber,
                  progressColor: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
