import 'package:dio/dio.dart';

class SimilarityData {
  final double cosineSimilarity;
  final double euclideanDistance;
  final double manhattanDistance;

  SimilarityData({
    required this.cosineSimilarity,
    required this.euclideanDistance,
    required this.manhattanDistance,
  });

  factory SimilarityData.fromJson(Map<String, dynamic> json) {
    return SimilarityData(
      cosineSimilarity: json['cosineSimilarity'] as double,
      euclideanDistance: json['euclideanDistance'] as double,
      manhattanDistance: json['manhattanDistance'] as double,
    );
  }
}



class ScoreService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getMovieScore(String movieName1, String movieName2) async {
    try {
      final response = await _dio.get(
        'http://192.168.1.129:5000/score/$movieName1/$movieName2'
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print("core url: http://192.168.1.129:5000/score/$movieName1/$movieName2");
      throw Exception('Failed to fetch movie score: $error');
    }
  }
}

