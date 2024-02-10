import 'dart:io';

import '../../app/logs.dart';
import '../../app/util/file_to_class_prefix.dart';
import 'bloc_content.dart';

void createBloc() {
  AppLogger.yellow('Пример: /Users/.../theme/dimensions.dart');
  stdout.write('${AppLogger.redText('Путь к файлу:')} ');
  String filePath = stdin.readLineSync()!;

  Uri uri = Uri.file(filePath);

  if (uri.pathSegments.isEmpty) {
    throw ArgumentError('Не корректный путь к файлу');
  }

  final dirtyFileName = uri.pathSegments.last;

  final pathWithoutName = uri.path.replaceAll(dirtyFileName, '');

  final fileName = _getClearFileName(dirtyFileName);
  final className = parseFileNameToClassPrefix(fileName);
  _createFiles(
    pathWithoutName: pathWithoutName,
    fileName: fileName,
    className: className,
  );
}

String _getClearFileName(String fileName) {
  return fileName.split('.').first.replaceAll('_page', '');
}

void _createFiles({
  required String pathWithoutName,
  required String fileName,
  required String className,
}) {
  final blocContent = BlocContent(className: className, fileName: fileName);
  File('${pathWithoutName}bloc/${fileName}_bloc.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(blocContent.bloc);
  });
  File('${pathWithoutName}bloc/${fileName}_state.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(blocContent.state);
  });
  File('${pathWithoutName}bloc/${fileName}_event.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(blocContent.event);
  });
  File('${pathWithoutName}bloc/${fileName}_bloc_model.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(blocContent.model);
  });

  AppLogger.green('Успешно созданы файлы: ${pathWithoutName}/bloc/');
}
