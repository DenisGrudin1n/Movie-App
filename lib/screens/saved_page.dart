import 'package:flutter/material.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SavedPage"),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
