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
              child: AddActivityButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NewActivityDialog(onSave: addNewActivity);
                    },
                  );
                },
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

class AddActivityButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AddActivityButton({super.key, required this.onPressed});

  @override
  AddActivityButtonState createState() => AddActivityButtonState();
}

class AddActivityButtonState extends State<AddActivityButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF3b234a) : const Color(0xFFbaafc4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: _isHovered ? const Color(0xFFbaafc4) : const Color(0xFF3b234a),
                  fontSize: 18,
                ),
                child: const Text("Adicionar Atividade"),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.add,
                color: _isHovered ? const Color(0xFFbaafc4) : const Color(0xFF3b234a),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
