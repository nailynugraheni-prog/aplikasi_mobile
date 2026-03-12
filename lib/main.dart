import 'package:cobadulu/core/constants/app_constants.dart';
import 'package:cobadulu/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cobadulu/features/dashboard/presentation/pages/dashboard_pages.dart';

void main() {
  // runApp(const MyApp());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: DashboardPage(),
    ); // MaterialApp
  }
}
/////////////////// riverpod modul 3
//import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'core/constants/app_constants.dart';
//import 'core/theme/app_theme.dart';
//import 'package:cobadulu/features/dashboard/presentation/pages/dashboard_pages.dart';

//void main() {
  //runApp(
    // ProviderScope adalah root untuk semua provider Riverpod
    //const ProviderScope(child: MyApp()),
  //);
//}

//class MyApp extends ConsumerWidget {
  //const MyApp({Key? key}) : super(key: key);

  //@override
  //Widget build(BuildContext context, WidgetRef ref) {
    //return MaterialApp(
      //title: AppConstants.appName,
      //debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme,
      //darkTheme: AppTheme.darkTheme,
      //themeMode: ThemeMode.light,
      //home: const DashboardPage(),
    //); // MaterialApp
  //}
//}

/////////////////modul 3
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'providers/dashboard_provider.dart';
//import 'pages/dashboard_page.dart';

//void main() {
  //runApp(const MyApp());
//}

//class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  //@override
  //Widget build(BuildContext context) {
    //return ChangeNotifierProvider(
      //create: (_) => DashboardProvider(),
      //child: MaterialApp(
        //title: 'Dashboard App',
        //debugShowCheckedModeBanner: false,
        //theme: ThemeData(primarySwatch: Colors.blue),
        //home: const DashboardPage(),
      //), // MaterialApp
    //); // ChangeNotifierProvider
  //}
//}
//////////////////////////Modul 2
// lib/main.dart
//import 'package:flutter/material.dart';

//void main() => runApp(const MyApp());

//class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  //@override
  //Widget build(BuildContext context) {
    //return MaterialApp(
      //title: 'Demo Dashboard',
      //theme: ThemeData(primarySwatch: Colors.indigo),
      //home: const DashboardPage(),
    //);
  //}
//}

//class DashboardPage extends StatelessWidget {
  //const DashboardPage({super.key});

  //Widget statCard(String title, String value, Color color) {
    //return Container(
      //padding: const EdgeInsets.all(16),
      //decoration: BoxDecoration(
        //color: color,
        //borderRadius: BorderRadius.circular(12),
        //boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 3))],
      //),
      //child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //children: [
          //Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          //const SizedBox(height: 8),
          //Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        //],
      //),
    //);
  //}

  //Widget gridItem(IconData icon, String title, String subtitle) {
    //return Container(
      //padding: const EdgeInsets.all(12),
      //decoration: BoxDecoration(
        //color: Colors.white,
        //borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: Colors.grey.shade200),
      //),
      //child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //children: [
          //Icon(icon, size: 28, color: Colors.indigo),
          //const Spacer(),
          //Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          //const SizedBox(height: 4),
          //Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        //],
      //),
    //);
  //}

  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: AppBar(
        //title: const Text('Dashboard Demo'),
        //actions: [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          //Padding(
            //padding: const EdgeInsets.only(right: 12),
            //child: CircleAvatar(backgroundColor: Colors.white24, child: const Icon(Icons.person, color: Colors.white)),
          //)
        //],
      //),
      //body: SingleChildScrollView(
        //padding: const EdgeInsets.all(16),
        //child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //children: [
            // ROW + CONTAINERS (stat cards)
            //Row(
              //children: [
                //Expanded(child: statCard('Users', '1.2k', Colors.indigo)),
                //const SizedBox(width: 12),
                //Expanded(child: statCard('Orders', '320', Colors.teal)),
                //const SizedBox(width: 12),
                //Expanded(child: statCard('Revenue', '\$8.4k', Colors.deepOrange)),
              //],
            //),

            //const SizedBox(height: 20),

            // STACK example
            //const Text('Stack example', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            //const SizedBox(height: 8),
            //Container(
              //height: 150,
              //decoration: BoxDecoration(
                //color: Colors.indigo.shade50,
                //borderRadius: BorderRadius.circular(12),
              //),
              //child: Stack(
                //children: [
                  // base card
                  //Positioned.fill(
                    //child: Padding(
                      //padding: const EdgeInsets.all(12),
                      //child: Container(
                        //decoration: BoxDecoration(
                          //color: Colors.indigo,
                          //borderRadius: BorderRadius.circular(10),
                        //),
                        //padding: const EdgeInsets.all(16),
                        //child: const Text('Background card', style: TextStyle(color: Colors.white, fontSize: 16)),
                      //),
                    //),
                  //),

                  // overlapping avatar / badge
                  //const Positioned(
                    //left: 18,
                    //top: 8,
                    //child: CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.star, color: Colors.indigo)),
                  //),

                  // positioned action
                  //Positioned(
                    //right: 14,
                    //bottom: 14,
                    //child: ElevatedButton.icon(
                      //onPressed: () {},
                      //icon: const Icon(Icons.open_in_new, size: 16),
                      //label: const Text('Open'),
                      //style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    //),
                  //)
                //],
              //),
            //),

            //const SizedBox(height: 20),

            // GridView (use shrinkWrap inside Column)
            //const Text('GridView (cards)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            //const SizedBox(height: 8),
            //GridView.count(
              //crossAxisCount: 2,
              //childAspectRatio: 3 / 2,
              //mainAxisSpacing: 12,
              //crossAxisSpacing: 12,
              //shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              //children: [
                //gridItem(Icons.shopping_bag, 'Products', '12 items'),
                //gridItem(Icons.people, 'Customers', '320 customers'),
                //gridItem(Icons.article, 'Reports', 'Monthly report'),
                //gridItem(Icons.settings, 'Settings', 'App settings'),
                //gridItem(Icons.feedback, 'Feedback', '24 messages'),
                //gridItem(Icons.map, 'Locations', '5 offices'),
              //],
            //),

            //const SizedBox(height: 20),

            // ListView (recent activities)
            //const Text('ListView (recent activity)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            //const SizedBox(height: 8),
            //ListView.separated(
              //shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              //itemCount: 5,
              //separatorBuilder: (_, __) => const Divider(height: 12),
              //itemBuilder: (context, index) {
                //return ListTile(
                  //contentPadding: EdgeInsets.zero,
                  //leading: CircleAvatar(backgroundColor: Colors.indigo.shade100, child: Icon(Icons.check_circle, color: Colors.indigo)),
                  //title: Text('Activity #${index + 1}'),
                  //subtitle: Text('Deskripsi singkat aktivitas ${index + 1}'),
                  //trailing: Text('2h ago', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                //);
              //},
            //),

            //const SizedBox(height: 20),

            // Contoh Container di dalam Column
            //const Text('Contoh Container di dalam Column', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            //const SizedBox(height: 8),
            //Container(
              //width: double.infinity,
              //padding: const EdgeInsets.all(12),
              //decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
              //child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //children: [
                  //Container(
                    //width: double.infinity,
                    //height: 80,
                    //decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                    //child: const Center(child: Text('Container 1', style: TextStyle(color: Colors.white, fontSize: 18))),
                  //),
                  //const SizedBox(height: 12),
                  //Container(
                    //width: double.infinity,
                    //height: 60,
                    //decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                    //child: const Center(child: Text('Container 2', style: TextStyle(color: Colors.white))),
                  //),
                //],
              //),
            //),

            //const SizedBox(height: 30),
            // footer / action
            //Row(
              //children: [
                //ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('New Item')),
                //const SizedBox(width: 12),
                //OutlinedButton(onPressed: () {}, child: const Text('Export')),
              //],
            //),
            //const SizedBox(height: 30),
          //],
        //),
      //),
    //);
  //}
//}