import 'package:expensetracker/cubits/commons/auth/auth_cubit.dart';
import 'package:expensetracker/screens/home/home.dart';
import 'package:expensetracker/screens/portfolio_page/portfolio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/floating_button/floating_button_animated.dart';

class HomePage extends StatefulWidget {
  final int pageIndex;
  const HomePage({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _pages = [
    const Home(),
    const PortfolioPage(),
    const Text('HI'),
    const Text('HIL'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: IconButton(
          color: Colors.grey[800],
          icon: const Icon(Icons.account_circle),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.grey[800],
            icon: const Icon(Icons.notifications),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
          IconButton(
            color: Colors.grey[800],
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().signOut();
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonAnimated(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.donut_large),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.account_balance_wallet),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.account_balance),
            label: 'Budget',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
