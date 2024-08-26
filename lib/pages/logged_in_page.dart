import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_2/pages/add_credit_card_page.dart';
import 'package:project_2/pages/add_transaction_page.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    AddTransaction(),
    AddCreditCard()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: GNav(
        gap: 10,
        tabBackgroundColor: Colors.grey.shade200,
        onTabChange: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.auto_graph,
            text: 'Add Card Transaction',
          ),

          GButton(
            icon: Icons.credit_card,
            text: 'Add Credit Card',
          ),
        ],
      ),
    );
  }
}