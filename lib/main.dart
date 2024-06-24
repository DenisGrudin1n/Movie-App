import 'package:flutter/material.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer<NavigationProvider>(
            builder: (context, navigationProvider, _) =>
                const CustomBottomNavigationBar().getPage(context),
          ),
        ),
      ),
    );
  }
}
