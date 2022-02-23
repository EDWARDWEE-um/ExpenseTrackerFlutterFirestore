import 'package:expensetracker/data/models/goal/goal.dart';
import 'package:flutter/material.dart';

class CreateEditGoalPageArgs {
  final Goal? goal;
  final String? documentId;

  CreateEditGoalPageArgs({required this.goal, required this.documentId});
}

class CreateEditGoalPage extends StatefulWidget {
  static const routeName = '/createEditGoal';
  final CreateEditGoalPageArgs args;

  const CreateEditGoalPage(this.args, {Key? key}) : super(key: key);

  @override
  State<CreateEditGoalPage> createState() => _CreateEditGoalPageState();
}

class _CreateEditGoalPageState extends State<CreateEditGoalPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
