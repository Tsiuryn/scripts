import 'dart:io';

import '../app/logs.dart';

void openXcodeProject() {
  stdout.write('${AppLogger.redText('Пример: /Users/.../ios/Runner.xcworkspace) \nПуть к Runner.xcworkspace:')} ');
  String projectPath = stdin.readLineSync()!;

  if (!File(projectPath).existsSync() && !Directory(projectPath).existsSync()) {
    print('Путь к проекту не существует: $projectPath');
    return;
  }

  try {
    Process.start('open', [projectPath]).then((Process process) {
      stdout.addStream(process.stdout);
      stderr.addStream(process.stderr);
      print('Открытие Xcode проекта: $projectPath');
    }).catchError((e) {
      print('Ошибка при открытии Xcode: $e');
    });
  } catch (e) {
    print('Ошибка: $e');
  }
}