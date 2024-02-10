class BlocContent {
  final String className;
  final String fileName;

  BlocContent({required this.className, required this.fileName});

  String get bloc => '''
import 'package:flutter_bloc/flutter_bloc.dart';

part '${fileName}_event.dart';

part '${fileName}_state.dart';

part '${fileName}_bloc_model.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}State.initial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  Future<void> _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<${className}State> emit,
  ) async {}
}
''';

  /// MODEL

  String get model => '''
part of '${fileName}_bloc.dart';

class ${className}BlocModel {
  final bool isInit;

  const ${className}BlocModel({
    required this.isInit,
  });

  const ${className}BlocModel.empty() : isInit = false;

  ${className}BlocModel copyWith({
    bool? isInit,
  }) =>
      ${className}BlocModel(
        isInit: isInit ?? this.isInit,
      );
}
''';

  /// STATE

  String get state => '''
part of '${fileName}_bloc.dart';

sealed class ${className}State {
  final ${className}BlocModel model;

  const ${className}State(this.model);

  factory ${className}State.initial() =>
      const InitialState(${className}BlocModel.empty());

  const factory ${className}State.loading(${className}BlocModel model) = LoadingState;
}

class InitialState extends ${className}State {
  const InitialState(super.model);
}

class LoadingState extends ${className}State {
  const LoadingState(super.model);
}
  ''';

  /// EVENT
  String get event => '''
part of '${fileName}_bloc.dart';

abstract class ${className}Event {
  const ${className}Event();

  const factory ${className}Event.initial() = InitialEvent;

  const factory ${className}Event.fetchData() = FetchDataEvent;
}

class InitialEvent extends ${className}Event {
  const InitialEvent();
}

class FetchDataEvent extends ${className}Event {
  const FetchDataEvent();
}
      ''';
}