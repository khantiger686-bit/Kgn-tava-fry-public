import 'package:flutter/material.dart';
void main() => runApp(const KGNPosApp());
class KGNPosApp extends StatelessWidget {
  const KGNPosApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN Waiter POS',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFff6a00)),
        scaffoldBackgroundColor: const Color(0xFFf8fafc),
      ),
      home: const TablesView(),
    );
  }
}
// MODELS + FULL APP - Copy full file from download
