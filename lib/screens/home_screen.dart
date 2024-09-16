// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:dev_management_timer/models/time_block.dart';
import 'package:dev_management_timer/services/notification_service.dart';
import 'package:dev_management_timer/widgets/time_block_card.dart';
import 'package:dev_management_timer/widgets/new_activity_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TimeBlock> timeBlocks = [
    TimeBlock(activityName: 'Estudar', duration: 60),
    TimeBlock(activityName: 'Trabalhar', duration: 120),
  ];

  void addNewActivity(TimeBlock timeBlock) {
    setState(() {
      timeBlocks.add(timeBlock);
    });
  }

  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Tempo'),
      ),
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          return TimeBlockCard(
            timeBlock: timeBlocks[index],
            onTimeComplete: () {
              NotificationService.showNotification(timeBlocks[index].activityName);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewActivityDialog(onSave: addNewActivity);
            },
          );
        },
      ),
    );
  }
}
