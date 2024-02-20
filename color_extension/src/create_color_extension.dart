import 'dart:io';

import '../../app/logs.dart';
import 'variable_parser.dart';
import 'variables.dart';

void createColorExtension() async {
  stdout.write('${AppLogger.redText(fileExample)}');
  String filePath = stdin.readLineSync()!;

  Uri uri = Uri.file(filePath);

  if (uri.pathSegments.isEmpty && !uri.pathSegments.last.contains('dart')) {
    throw ArgumentError('Не корректный путь к файлу');
  }

  String sourceText = await File(filePath).readAsString();
  final VariableParser variableParser = VariableParser(
    sourceText: sourceText,
    className: 'AppExtension',
  );

  final oldFileName = uri.pathSegments.last;

  _createFile(
    path: filePath.replaceAll(oldFileName, 'app_extension.dart'),
    classText: variableParser.classText,
    initializer: variableParser.initializer,
  );
}

void _createFile({
  required String path,
  required String classText,
  required String initializer,
}) {
  File(path).create(recursive: true).then((file) {
    file.writeAsStringSync('$classText \n $initializer');
  });

  AppLogger.green('Файл успешно создан: $path');
}
