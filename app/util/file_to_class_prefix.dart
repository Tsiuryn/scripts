import 'capitalize.dart';

String parseFileNameToClassPrefix(String fileName) {
  final parser = fileName.split('_');
  var title = '';
  for (var element in parser) {
    title += element.capitalize();
  }
  return title;
}