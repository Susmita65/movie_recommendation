
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sstfix/service/auth_service.dart';
import 'package:sstfix/service/review_service.dart';

import '../common_state.dart';

final reviewProvider = StateNotifierProvider<ReviewProvider, CommonState>((ref) => ReviewProvider(CommonState.empty(), ref.watch(authService)));

class ReviewProvider extends StateNotifier<CommonState>{
  final AuthService service;
  ReviewProvider(super.state, this.service);

  Future<void> addReview({
    required  String user_id,
    required int movie_id,
    required String review,
  }) async{
    state = state.copyWith(isLoad: true, errText: '', isError: false, isSuccess: false);
    final response = await ReviewService().addReview(user_id: user_id, movie_id: movie_id, review: review);
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
