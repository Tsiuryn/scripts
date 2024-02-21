class CleanArchContent {
  final String className;
  final String fileName;

  CleanArchContent ({
    required this.className,
    required this.fileName,
  });

  String get _classInstance => className.toLowerCase();


  String get useCase  => '''
  import 'package:uni_clean_arch/uni_clean_arch.dart';

///RU: [${className}UseCase]  ;
///
///ENG: [${className}UseCase] ;
///
class ${className}UseCase
    extends UniFutureUseCase<${className}Entity, ${className}Entity> {
  final ${className}Gateway ${_classInstance}Gateway;

  ${className}UseCase({required this.corpopassCardGateway});

  @override
  Future<${className}Entity> execute([${className}Entity? input]) {
    if (input == null) {
      throw ArgumentError('${className}Response can not be null');
    }

    return ${_classInstance}Gateway.send(input);
  }
}
  ''';

  String get entity  => '''
  class ${className}Entity {
  final bool isSuccess;
  final int code;

  const ${className}Entity({
    required this.isSuccess,
    required this.code,
  });
}
  ''';

  String get gateWay  => '''
  import 'package:uni_core_types/uni_core_types.dart';

///RU: [${className}Gateway] ;
///
///ENG: [${className}Gateway] ;
///
abstract interface class ${className}Gateway {
  ///RU: [send]  ;
  ///
  ///ENG: [send] ;
  ///
  Future<${className}Response> send(${className}Response request);
}
  ''';

  String get gateWayImpl  => '''
  import 'package:uni_core_types/uni_core_types.dart';

class ${className}GatewayImpl implements ${className}Gateway {
  final ${className}Source ${_classInstance}Source;
  final ${className}Mapper ${_classInstance}Mapper;

  const CorpopassCardGatewayImpl({
    required this.${_classInstance}Source,
    required this.${_classInstance}Mapper,
  });

  @override
  Future<${className}Response> send(${className}Response request) async {
    return ${_classInstance}Source
        .send(request.code)
        .then((value) {
      return ${_classInstance}Mapper.mapFromBean(value);
    });
  }
}
  ''';
  String get dataSource  => '''
abstract interface class ${className}Source {

  Future<${className}ResponseBody> send(
      int code);

}
  ''';
  String get dataSourceImpl  => '''
  class Remote${className}DataSource implements ${className}Source {
  final ${className}Api ${_classInstance}Api;

  Remote${className}DataSource(this.${_classInstance}Api);

  @override
  Future<${className}ResponseBody> send(
      int code) async {
    return ${_classInstance}Api.send(code);
  }
}
  ''';

  String get mapper  => '''
import 'package:uni_clean_arch/uni_clean_arch.dart';

class ${className}Mapper
    extends UniMapper<${className}Entity, ${className}ResponseBody> {
    
  @override
  ${className}Entity mapFromBean(${className}ResponseBody src) {
     // TODO: implement mapToBean
    throw UnimplementedError();
  }

  @override
  ${className}ResponseBody mapToBean(${className}Entity src) {
    // TODO: implement mapToBean
    throw UnimplementedError();
  }
}
  ''';

  String get bean  => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:uni_json_converters/uni_json_converters.dart';

part '${fileName}_response_body.g.dart';

@JsonSerializable()
class ${className}ResponseBody {
  @JsonKey(name: 'isSuccess')
  final bool? isSuccess;

  @JsonKey(name: 'code')
  final int? code;

  const ${className}ResponseBody({
    required this.isSuccess,
    required this.code,
  });

  factory ${className}ResponseBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _\$${className}ResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _\$${className}ResponseBodyToJson(this);
}
  ''';

  String get api  => '''
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part '${fileName}_api.g.dart';

@RestApi()
abstract class ${className}Api {
  factory ${className}Api(Dio dio, {String baseUrl}) = _${className}Api;

  @GET('send/{code}')
  Future<${className}ResponseBody> send(
    @Path('code') final int code,
  );
}
  ''';
}