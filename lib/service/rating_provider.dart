
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sstfix/service/auth_service.dart';
import 'package:sstfix/service/rating_service.dart';
import '../common_state.dart';

final ratingProvider = StateNotifierProvider<RateProvider, CommonState>((ref) => RateProvider(CommonState.empty(), ref.watch(authService)));

class RateProvider extends StateNotifier<CommonState>{
  final AuthService service;
  RateProvider(super.state, this.service);

  Future<void> addRating({
    required  String user_id,
    required int movie_id,
    required double rating,
  }) async{
    state = state.copyWith(isLoad: true, errText: '', isError: false, isSuccess: false);
    final response = await RateService().addRatings(user_id: user_id, movie_id: movie_id, rating: rating);
    response.fold(
            (l) {
          state = state.copyWith(isLoad: false, errText: l, isError: true, isSuccess: false);
        },
            (r) {
          state = state.copyWith(isLoad: false, errText: '', isError: false, isSuccess: r);
        }
    );
  }
}
