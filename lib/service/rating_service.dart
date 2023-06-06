
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../api/api.dart';

class RateService {

  Future<Either<String, bool>> addRatings({
    required  String user_id,
    required int movie_id,
    required double rating,
  }) async{
    try {
      final response = await Dio().get("${Api.baseUrl}rate/$movie_id/$rating/$user_id");
      return Right(true);
    } on DioError catch (err) {
      return Left(err.message.toString());
    }
  }
}

