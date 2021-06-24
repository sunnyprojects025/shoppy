import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/provider/detailsProvider.dart';
import 'package:shoppy/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Detailsprovider())],
      child: MaterialApp(
        title: 'Shoppy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
    debugShowCheckedModeBanner: false,
      home: Homepage()));
    
  }
}

