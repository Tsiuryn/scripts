import 'dart:io';

import '../../app/logs.dart';
import '../../app/util/file_to_class_prefix.dart';
import 'clean_arch_content.dart';

void generateCleanArch() {
  stdout.write('${AppLogger.redText('Пример: /Users/.../payment) \nПуть к папке:')} ');
  String filePath = stdin.readLineSync()!;

  Uri uri = Uri.file(filePath);

  if (uri.pathSegments.isEmpty) {
    throw ArgumentError('Не корректный путь к файлу');
  }

  final directoryName = uri.pathSegments.last;

  final className = parseFileNameToClassPrefix(directoryName);
  _createFiles(
    path: uri.path,
    fileName: directoryName,
    className: className,
  );
}

void _createFiles({
  required String path,
  required String fileName,
  required String className,
}) {
  final content = CleanArchContent(className: className, fileName: fileName);
  final domainPath = '${path}/domain/';
  final dataPath = '${path}/data/';
  File('${domainPath}/usecase/${fileName}_usecase.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.useCase);
  });
  File('${domainPath}/gateway/${fileName}_gateway.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.gateWay);
  });
  File('${domainPath}/entity/${fileName}_entity.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.entity);
  });


  File('${dataPath}/gateway/${fileName}_gateway.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.gateWayImpl);
  });
  File('${dataPath}/mapper/${fileName}_mapper.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.mapper);
  });
  File('${dataPath}/source/${fileName}_source.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.dataSource);
  });
  File('${dataPath}/source/remote/remote_${fileName}_data_source.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.dataSourceImpl);
  });
  File('${dataPath}/source/remote/model/${fileName}_response_body.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.bean);
  });
  File('${dataPath}/source/remote/api/${fileName}_api.dart')
      .create(recursive: true)
      .then((file) {
    file.writeAsStringSync(content.api);
  });


  AppLogger.green('Файлы успешно создан: $path');
}
