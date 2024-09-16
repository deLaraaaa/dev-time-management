// lib/screens/time_history_screen.dart

import 'package:flutter/material.dart';

class TimeHistoryScreen extends StatelessWidget {
  const TimeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Tempo')),
      body: const Center(
        child: Text('Histórico das atividades finalizadas aparecerá aqui'),
      ),
    );
  }
}
