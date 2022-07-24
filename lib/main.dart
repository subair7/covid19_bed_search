import 'package:covid19/screens/bottom_nav_screen.dart';
import 'package:covid19/screens/home_screen.dart';
import 'package:covid19/screens/stats_screen.dart';
import 'package:covid19/services/connectivity_service.dart';
import 'package:covid19/services/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (BuildContext context) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Cellular,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        debugShowCheckedModeBanner: false,
        title: 'Covid-19',
        initialRoute: BottomNavScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          StatsScreen.routeName: (context) => StatsScreen(),
          BottomNavScreen.routeName: (context) => BottomNavScreen(),
        },
      ),
    );
  }
}
