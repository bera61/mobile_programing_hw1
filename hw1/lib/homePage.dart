import 'package:flutter/material.dart';
import 'tabs/hakkinda.dart';
import 'tabs/kisiler.dart';
import 'tabs/dersler.dart';
import 'tabs/altyapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.white, 
            unselectedLabelColor: Colors.white70, 
            indicatorColor: Colors.white, 
            tabs: [
              Tab(text: 'Hakkında'),
              Tab(text: 'Kişiler'),
              Tab(text: 'Altyapı'),
              Tab(text: 'Dersler'),
            ],
          ),
        ), 
        
        body: TabBarView(
          children: [
            hakkinda(),
            Kisiler(),
            Altyapi(),
            dersler(),
          ],
        ),
      ),
    );
  }
}
