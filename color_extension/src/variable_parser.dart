class VariableParser {
  final String _sourceText;
  final String _className;

  VariableParser({
    required String sourceText,
    required String className,
  }) : _className = className, _sourceText = sourceText {
    variables = _getListVariable(_sourceText);
  }

  String get initializer => _createInit();

  String _createInit() {
    String textVariables = '';
    for (var element in variables) {
      textVariables += '  ${element.name}: ${element.value},\n';
    }

    return '''
const ${_className.toLowerCase()} = $_className(
$textVariables
);
  ''';
  }



  String get classText => '''
import 'package:flutter/material.dart';

class $_className
    extends ThemeExtension<$_className> {
    ${_createVariables()}
    ${_createConstructor()}
    ${_createLerpMethod()}
    ${_createCopyWithMethod()}
}
  ''';

  late List<AppVariable> variables;

  String _createCopyWithMethod() {
    String inputText(){
      String textVariables = '';

      for (var element in variables) {
        textVariables += '      ${element.type}? ${element.name},\n';
      }
      return textVariables;
    }
    String outputText(){
      String textVariables = '';

      for (var element in variables) {
        textVariables += '      ${element.name}: ${element.name} ?? this.${element.name},\n';
      }
      return textVariables;
    }

    return '''
    @override
  $_className copyWith({
    ${inputText()}
  }) {
    return $_className (
      ${outputText()}
    );
  }  
  ''';
  }

  String _createLerpMethod(){
    String getVariables (){
      String textVariables = '';

      for (var element in variables) {
        textVariables += '      ${element.name}: ${element.type}.lerp(${element.name}, other.${element.name}, t)!,\n';
      }
      return textVariables;
    }

    return '''
    @override
  ThemeExtension<$_className> lerp (
      covariant ThemeExtension<$_className>? other, double t) {
    if (other is! $_className) {
      return this;
    }
    return $_className(
      ${getVariables()}
    );
  }
  ''';
  }

  String _createConstructor() {
    String textVariables = 'const $_className ({\n';
    for (var element in variables) {
      textVariables += 'required this.${element.name},\n';
    }
    textVariables += '});';
    return textVariables;
  }

  String _createVariables() {
    String textVariables = '';
    for (var element in variables) {
      textVariables += '    final ${element.type} ${element.name};\n';
    }
    return textVariables;
  }

  List<AppVariable> _getListVariable(String sourceText){
    List<AppVariable> variables= [];
    var listText = sourceText.split('\n');

    AppVariable? parseVariable(String text) {
      RegExp regExp = RegExp(r'static const\s+(\w+)\s+(\w+)\s+=\s+(.*);');
      Match? match = regExp.firstMatch(text);

      String? type = match?.group(1); // "Color"
      String? variableName = match?.group(2); // "danger"
      String? value = match?.group(3); // "Color(0xffffffff)"
      if (type == null || variableName == null || value == null) {
        print('Can not parse : ${text.isEmpty ? 'empty text' : text}');
        return null;
      }

      return AppVariable(type: type, name: variableName, value: value);
    }

    for (var o in listText) {
      final variable = parseVariable(o);
      if(variable != null){
        variables.add(variable);
      }
    }


    return variables;
  }
}

class AppVariable {
  final String type;
  final String name;
  final String value;

  const AppVariable({
    required this.type,
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return 'AppVariable{type: $type, name: $name, value: $value}';
  }
}
