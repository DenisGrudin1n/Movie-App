import 'package:flutter/material.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SearchPage"),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
