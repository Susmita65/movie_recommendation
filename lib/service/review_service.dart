
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../api/api.dart';

class ReviewService {

  Future<Either<String, bool>> addReview({
    required  String user_id,
    required int movie_id,
    required String review,
  }) async{
    try {
      final response = await Dio().get("${Api.baseUrl}review/$movie_id/$review/$user_id");
      return Right(true);
    } on DioError catch (err) {
      return Left(err.message.toString());
    }
  }
}

