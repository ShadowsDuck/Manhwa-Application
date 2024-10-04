import 'package:account/screens/favorite_screen.dart';
import 'package:account/screens/home_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Manhwa Application',
        theme: ThemeData(
          textTheme: GoogleFonts.baiJamjureeTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const MyHomePage(
          title: 'Manhwa Application',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomeScreen2(),
            FavoriteScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'หน้าหลัก'),
            Tab(icon: Icon(Icons.favorite_rounded), text: 'กดถูกใจ'),
          ],
        ),
      ),
    );
  }
}
