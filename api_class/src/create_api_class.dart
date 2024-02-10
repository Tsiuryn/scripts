import 'dart:io';

import '../../app/logs.dart';
import '../../app/util/file_to_class_prefix.dart';
import 'api_class_content.dart';

void createApiClass() {
  stdout.write('${AppLogger.redText('Пример: /Users/.../theme/dimensions.dart) \nВведите путь к файлу:')} ');
  String filePath = stdin.readLineSync()!;

  Uri uri = Uri.file(filePath);

  if (uri.pathSegments.isEmpty) {
    throw ArgumentError('Не корректный путь к файлу');
  }

  final dirtyFileName = uri.pathSegments.last;

  final fileName = _getClearFileName(dirtyFileName);
  final className = parseFileNameToClassPrefix(fileName);
  _createFiles(
    path: uri.path,
    fileName: fileName,
    className: className,
  );
}

String _getClearFileName(String fileName) {
  return fileName.split('.').first;
}

void _createFiles({
  required String path,
  required String fileName,
  required String className,
}) {
  final content = ApiClassContent(className: className, fileName: fileName);
  File(path)
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.body);
  });


  AppLogger.green('Файл успешно создан: $path');
}
