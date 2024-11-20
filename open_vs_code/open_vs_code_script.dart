import 'dart:io';

import '../app/logs.dart';

///Добавление команды code в терминал
// Откройте Visual Studio Code.
// Нажмите Cmd + Shift + P, чтобы открыть палитру команд.
// Введите Shell Command: Install 'code' command in PATH и выберите это действие.
void openVSCodeProject() {
  stdout.write('${AppLogger.greenText('Пример: /Users/.../notification) \nПуть к директории проекта:')} ');
  String projectPath = stdin.readLineSync()!;

  if (!Directory(projectPath).existsSync()) {
    print('Путь к проекту не существует: $projectPath');
    return;
  }

  try {
    Process.start('code', [projectPath]).then((Process process) {
      stdout.addStream(process.stdout);
      stderr.addStream(process.stderr);
      print('Открытие проекта в VS Code: $projectPath');
    }).catchError((e) {
      print('Ошибка при открытии VS Code: $e');
    });
  } catch (e) {
    print('Ошибка: $e');
  }
}