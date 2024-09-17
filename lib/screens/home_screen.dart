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
  List<TimeBlock> timeBlocks = [];

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
      body: timeBlocks.isEmpty
          ? Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: const Color(0xFFbaafc4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NewActivityDialog(onSave: addNewActivity);
                    },
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Adicionar Atividade",
                      style: TextStyle(color: Color(0xFF3b234a), fontSize: 18),
                    ),
                    SizedBox(
                        width:
                            8),
                    Icon(Icons.add, color: Color(0xFF3b234a)),
                  ],
                ),
              ),
            )
          : ListView.builder(
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
      floatingActionButton: timeBlocks.isNotEmpty
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewActivityDialog(onSave: addNewActivity);
                  },
                );
              },
            )
          : null,
    );
  }
}
