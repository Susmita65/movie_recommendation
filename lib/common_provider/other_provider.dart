import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginProvider, bool>((ref) => LoginProvider(true));

class LoginProvider extends StateNotifier<bool>{
  LoginProvider(super.state);
  void change(){
    state = !state;
  }
}
final passHide = StateProvider.autoDispose<bool>((ref) =>true );





final mode = StateNotifierProvider.autoDispose<ModeProvider, AutovalidateMode>((ref) => ModeProvider(AutovalidateMode.disabled));

class ModeProvider extends StateNotifier<AutovalidateMode>{
  ModeProvider(super.state);

  void change(){
    state = AutovalidateMode.onUserInteraction;
  }

}
