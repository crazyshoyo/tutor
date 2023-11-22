import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/core/error/exceptions.dart';
import 'package:tutor_lms/core/error/failures.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/singleCourseResponse.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/single_category_response.dart';
import 'package:tutor_lms/data.datasource/remote/services/apis.dart';
import 'package:tutor_lms/data.datasource/remote/services/dio/rest_client.dart';

class CourseRepositoryImpl {

  final restClient = Get.find<RestClient>();

  Future<Either<Failure, SingleCourseResponse>> singleCourse(String slug) async {
    try {
      final response = await restClient.get(url: "${Apis.getSingleCourse}$slug",);
      return Right(singleCourseResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }


  Future<Either<Failure, CategoryResponse>> getCategory(String slug) async {
    try {
      final response = await restClient.get(url: "${Apis.getCategory}$slug");
      return Right(categoryResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }
}