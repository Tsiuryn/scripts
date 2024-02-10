class ApiClassContent {
  final String className;
  final String fileName;

  ApiClassContent({
    required this.className,
    required this.fileName,
  });

  String get body => '''
  import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part '$fileName.g.dart';

@RestApi()
abstract class $className {
  factory $className(Dio dio, {String baseUrl}) = _$className;

  @POST('flow/{id}')
  Future<MyClass> getToken(
      @Path('id') final String activationCode,
      );

  @GET('/activate/{id}/start')
  Future<MyClass> requestMyCode(
      @Path('id') final String activeCode,
      );

  @PUT('corpopass/activate')
  Future<MyClass> activationMethod(
      @Body() final MyClassRequestBody activationBody,
      );
}
''';
}
