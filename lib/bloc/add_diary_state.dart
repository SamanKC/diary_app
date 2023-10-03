part of 'add_diary_bloc.dart';

abstract class DiaryState {}

class InitialDiaryState extends DiaryState {}

class LoadingDiaryState extends DiaryState {}

class SuccessDiaryState extends DiaryState {}

class ErrorDiaryState extends DiaryState {
  final String errorMessage;

  ErrorDiaryState(this.errorMessage);
}
