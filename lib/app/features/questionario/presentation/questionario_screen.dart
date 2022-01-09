import 'package:flutter/material.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({Key? key,required this.quizEntity})
      : super(key: key);
  final QuizEntity quizEntity;
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
