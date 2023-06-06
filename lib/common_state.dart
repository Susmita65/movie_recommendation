import 'package:freezed_annotation/freezed_annotation.dart';


@freezed
class CommonState{
  final bool isLoad;
  final bool isError;
  final bool isSuccess;
  final String errText;

  CommonState({
    required this.isLoad,
    required this.errText,
    required this.isError,
    required this.isSuccess
});



factory CommonState.empty(){
  return CommonState(isLoad: false, isError: false, isSuccess: false, errText: '');
}

CommonState copyWith(
  {
    bool? isLoad,
    bool? isError,
    bool? isSuccess,
    String? errText
}
    ){
  return  CommonState(
      isLoad: isLoad ?? this.isLoad,
      errText: errText ?? this.errText,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess
  );
}
}


