import 'package:flutter/material.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({Key? key}) : super(key: key);

  @override
  _QuestionarioScreenState createState() => _QuestionarioScreenState();
}

class _QuestionarioScreenState extends State<QuestionarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
    );
  }
}
