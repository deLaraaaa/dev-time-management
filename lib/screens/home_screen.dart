import 'package:flutter/material.dart';
import 'package:dev_management_timer/models/time_block.dart';
import 'package:dev_management_timer/services/notification_service.dart';
import 'package:dev_management_timer/widgets/time_block_card.dart';
import 'package:dev_management_timer/widgets/new_activity_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

 @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<TimeBlock> timeBlocks = [
    TimeBlock(activityName: 'Estudar', duration: 60),
    TimeBlock(activityName: 'Trabalhar', duration: 120),
  ];

  void addNewActivity(TimeBlock timeBlock) {
    setState(() {
      timeBlocks.add(timeBlock);
    });
  }

  void deleteActivity(int index) {
    setState(() {
      timeBlocks.removeAt(index);
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
        title: const Text('Gestor de Tempo'),
      ),
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          return TimeBlockCard(
            timeBlock: timeBlocks[index],
            onTimeComplete: () {
              NotificationService.showNotification(timeBlocks[index].activityName);
            },
            onDelete: () {
              deleteActivity(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color(0xFFbaafc4),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewActivityDialog(onSave: addNewActivity);
            },
          );
        },
        child: const Icon(Icons.add, color: Color(0xFF3b234a)),
      ),
    );
  }
}
