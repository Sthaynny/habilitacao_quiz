import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/Indicador_questoes_widget.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/primary_button_widget.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({Key? key, required this.quizEntity})
      : super(key: key);
  final QuizEntity quizEntity;
  @override
  _QuestionarioScreenState createState() => _QuestionarioScreenState();
}

class _QuestionarioScreenState extends State<QuestionarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(86),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.vermelhoEscuro,
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        true,
                      );
                    }),
                const IndicadorQuestoesWidget(
                  currentPage: 1,
                  length: 20,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Row(
              children: const [
                Flexible(child: PrimaryButtonWidget.branco(label: 'voltar')),
                Flexible(child: PrimaryButtonWidget.azul(label: 'avançar')),
              ],
            ),
          ),
        ));
  }
}
