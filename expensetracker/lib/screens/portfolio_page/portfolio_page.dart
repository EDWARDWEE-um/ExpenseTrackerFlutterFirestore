import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PortfolioPage extends StatefulWidget {
  static const routeName = '/portfolio';

  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String? user = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('hi');
  }
}
