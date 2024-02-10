class SerializableContent {
  final String className;
  final String fileName;

  SerializableContent({
    required this.className,
    required this.fileName,
  });

  String get body => '''
  import 'package:json_annotation/json_annotation.dart';

part '$fileName.g.dart';

@JsonSerializable()
class $className {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(
    name: 'type',
    unknownEnumValue: ResponseType.unknown,
  )
  final ResponseType? type;

  const $className({
    required this.id,
    required this.type,
  });

  factory $className.fromJson(
      Map<String, dynamic> json,
      ) =>
      _\$${className}FromJson(json);

  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
}

enum ResponseType {
  @JsonValue('SUCCESS')
  success,
  @JsonValue('ERROR')
  error,
  @JsonValue('')
  unknown,
}
''';

}
