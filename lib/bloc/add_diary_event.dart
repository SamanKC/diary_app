part of 'add_diary_bloc.dart';

abstract class DiaryEvent {}

class AddDiaryDataEvent extends DiaryEvent {
  final Map<String, dynamic>? diaryData;
  final List<XFile>? selectedImages;

  AddDiaryDataEvent({this.diaryData, this.selectedImages});
}
