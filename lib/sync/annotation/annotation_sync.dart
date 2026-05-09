import 'package:dio/dio.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/sync/annotation/annotation_controller.dart';

import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class AnnotationSync {
  Future<void> getAnnotation() async {
    Response response = await Network(ConfigApi(), [Endpoint.annotation]).get();

    AnnotationController annotationController = AnnotationController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Annotation annotation = Annotation.fromMapToObject(item);

        annotationController.annotations.add(annotation);
      }
      await annotationController.deleteTable();

      await annotationController.writeAnnotation();
    }
  }

  Future<void> postAnnotation() async {
    List<Annotation> lists = await GetAnnotation(AnnotationDatabase()).findAnnotationSync() ?? [];

    if (lists.isNotEmpty) {
      for (Annotation item in lists) {
        int idOld = item.id!;

        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.annotation]).post(Annotation.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = false;
          item.insertApp = false;
          item.id = idOld;

          await UpdateAnnotation(AnnotationDatabase(), annotation: item).write();
        }
      }
    }
  }

  Future<void> postAnnotationDisable() async {
    List<Annotation> lists = await GetAnnotation(AnnotationDatabase()).findAnnotationDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Annotation item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.annotation, Endpoint.update]).post(RequestItem().convert(item));

        if (response.data != null) {
          item.sync = false;

          await UpdateAnnotation(AnnotationDatabase(), annotation: item).write();
        }
      }
    }
  }
}
