import 'dart:io';

import '../app/logs.dart';

const _reminder = 'Команда должна запускаться в директории репозитория проекта! \n';

const _mobileText = '$_reminderВыбор мобильной платформы:\n'
    '1. Андроид appbundle\n'
    '2. Андроид apk\n'
    '3. Иос\n';

const _exportMethod = '\nIOS export method:\n'
    '1. Development\n'
    '2. Ad-Hoc (use for upload to testing in Firebase)\n'
    '3. Enterprise\n'
    '4. App-store (use for upload to TestFlight)\n';

const _platformText = '\nВыбор платформы:\n'
    '1. BatteryFly\n'
    '2. Evika\n'
    '3. PSS\n';

const _envText = '\nВыбор линейки:\n'
    '1. Stage\n'
    '2. Prod\n';

enum Platform {
  appbundle('appbundle'),
  apk('apk'),
  ipa('ipa');

  const Platform(this.type);

  final String type;

  static Platform fromString(String platform) =>
      switch(platform) {
        '1' => Platform.appbundle,
        '2' => Platform.apk,
        '3' => Platform.ipa,
        _ => throw ArgumentError('Platform $platform отсутствует'),
      };
}

enum Flavor {
  batteryfly,
  evika,
  pss;

  static Flavor fromString(String flavor) =>
      switch(flavor) {
        '1' => Flavor.batteryfly,
        '2' => Flavor.evika,
        '3' => Flavor.pss,
        _ => throw ArgumentError('Flavor $flavor отсутствует'),
      };
}

enum Environment {
  stage,
  prod;

  static Environment fromString(String env) =>
      switch(env) {
        '1' => Environment.stage,
        '2' => Environment.prod,
        _ => throw ArgumentError('Environment $env отсутствует'),
      };
}

enum IosExportMethod {
  development('development'),
  adHoc('ad-hoc'),
  enterprise('enterprise'),
  appStore('app-store');

  const IosExportMethod(this.value);

  final String value;

  static IosExportMethod fromString(String env) =>
      switch(env) {
        '1' => IosExportMethod.development,
        '2' => IosExportMethod.adHoc,
        '3' => IosExportMethod.enterprise,
        '4' => IosExportMethod.appStore,
        _ => throw ArgumentError('IosExportMethod $env отсутствует'),
      };
  //export-method:
  // - development
  // - ad-hoc
  // - enterprise
  // - app-store
}

void runFlutterBuild() async {
  List<String> arguments = ['-c'];
  stdout.write('${AppLogger.blueText(_mobileText)} ');
  Platform platform = Platform.fromString(stdin.readLineSync()!);
  arguments.add('flutter build ${platform.type} --release');

  if(platform == Platform.ipa){
    stdout.write('${AppLogger.blueText(_exportMethod)} ');
    IosExportMethod exportMethod = IosExportMethod.fromString(stdin.readLineSync()!);
    arguments.add('--export-method=${exportMethod.value}');
  }

  stdout.write('${AppLogger.blueText(_platformText)} ');
  Flavor flavor = Flavor.fromString(stdin.readLineSync()!);
  arguments.add('--flavor=${flavor.name}');

  stdout.write('${AppLogger.blueText(_envText)} ');
  String env = stdin.readLineSync()!;
  arguments.add(_getConfig(flavor, Environment.fromString(env)));

  final command = arguments.reduce((first, second) => '$first $second').replaceFirst('-c ', '');
  AppLogger.green(command);
  await _copyToClipboard(command);
}

String _getConfig(Flavor flavor, Environment env) {
  return switch(flavor){
    Flavor.batteryfly => _getBFConfig(env),
    Flavor.evika => _getEvikaConfig(env),
    Flavor.pss => _getPssConfig(env),
  };
}

String _getBFConfig(Environment env)=> switch(env){
    Environment.prod => '--dart-define-from-file=.configs/bf_prod.json',
    Environment.stage => '--dart-define-from-file=.configs/bf_stage.json',
  };

String _getEvikaConfig(Environment env)=> switch(env){
    Environment.prod => '--dart-define-from-file=.configs/evika_prod.json',
    Environment.stage => '--dart-define-from-file=.configs/evika_stage.json',
  };

String _getPssConfig(Environment env)=> switch(env){
    Environment.prod => '--dart-define-from-file=.configs/pss_prod.json',
    Environment.stage => '--dart-define-from-file=.configs/pss_stage.json',
  };

Future _copyToClipboard(String text) async{
  try {
    Process? process = await Process.start('pbcopy', []);

    // Отправляем текст в поток ввода процесса
    process.stdin.write(text);
    await process.stdin.close();

    await process.exitCode; // Ожидаем завершения процесса
    AppLogger.blue('Команда скопирована в буфер обмена');
  } catch (e) {
    AppLogger.red('Ошибка копирования команды в буфер обмена: $e');
  }
}
