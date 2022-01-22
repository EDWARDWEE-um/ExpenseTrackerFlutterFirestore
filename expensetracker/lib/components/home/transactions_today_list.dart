import 'package:flutter/material.dart';

class TransactionsTodayList extends StatefulWidget {
  const TransactionsTodayList({Key? key}) : super(key: key);

  @override
  _TransactionsTodayListState createState() => _TransactionsTodayListState();
}

class _TransactionsTodayListState extends State<TransactionsTodayList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 200,
       
      ),
    );
  } 
}