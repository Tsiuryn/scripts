import 'dart:io';

import '../app/logs.dart';

void openAndroidStudio() {
  stdout.write('${AppLogger.redText('Пример: /Users/.../notification) \nПуть к папке проекта:')} ');
  String projectPath = stdin.readLineSync()!;

  String androidStudioPath = '/Applications/Android Studio.app/Contents/MacOS/studio';

  // Проверьте, существует ли указанный путь к проекту
  if (!Directory(projectPath).existsSync()) {
    print('Путь к проекту не существует: $projectPath');
    return;
  }

  // Попытка открыть Android Studio с указанным проектом
  try {
    Process.start(androidStudioPath, [projectPath]).then((Process process) {
      stdout.addStream(process.stdout);
      stderr.addStream(process.stderr);
      print('Открытие проекта Android Studio: $projectPath');
    }).catchError((e) {
      print('Ошибка при открытии Android Studio: $e');
    });
  } catch (e) {
    print('Ошибка: $e');
  }
}