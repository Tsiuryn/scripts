import 'dart:io';

import 'api_class/src/create_api_class.dart';
import 'bloc_by_page/src/create_bloc.dart';
import 'clean_arch/src/generate_clean_arch.dart';
import 'color_extension/src/create_color_extension.dart';
import 'flutter_build/flutter_build_app.dart';
import 'g_class_serializable/src/create_g_class.dart';
import 'open_as/open_as_script.dart';
import 'open_vs_code/open_vs_code_script.dart';
import 'open_xcode/open_xcode_script.dart';

void main() {
  stdout.write(_text);
  String programNumber = stdin.readLineSync()!;

  switch (int.tryParse(programNumber)) {
    case 1:
      createBloc();
    case 2:
      createGClass();
    case 3:
      createApiClass();
    case 4:
      generateCleanArch();
    case 5:
      createColorExtension();
    case 6:
      runFlutterBuild();
    case 7:
      openAndroidStudio();
    case 8:
      openXcodeProject();
    case 9:
      openVSCodeProject();
    case null:
    default:
      {
        throw ArgumentError('Неизвестная программа!');
      }
  }
}

const _text = '''
Возможности скрипта:
1. Создание файлов менеджера состояния - Bloc;
2. Создание примера g_class;
3. Создание класса API retrofit;
4. Создание слоев чистой архитектуры;
5. Создание файла с классом расширения;
6. Генерация команды для сборки Batteryfly проекта;
7. Открыть проект в Android Studio;
8. Открыть проект в Xcode;
9. Открыть проект в VS Code;
Выберите нужную программу: 
''';
