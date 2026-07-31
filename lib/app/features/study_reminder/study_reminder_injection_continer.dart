import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/data/local_study_notification_service.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/data/study_reminder_datasource.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/domain/study_reminder_service.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class StudyReminderInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<StudyReminderDatasource>(
      () => StudyReminderDatasource(),
      fenix: true,
    );
    Get.lazyPut<LocalStudyNotificationService>(
      () => LocalStudyNotificationService(),
      fenix: true,
    );
    Get.lazyPut<StudyReminderService>(
      () => StudyReminderService(Get.find(), Get.find()),
      fenix: true,
    );
  }
}
