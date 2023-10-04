import 'package:diary_app/models/diary_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diary_app/bloc/add_diary_bloc.dart';

void main() {
  group('DiaryBloc Tests', () {
    test('AddDiaryDataEvent handles data correctly', () {
      final event = AddDiaryDataEvent(
          diaryData: DiaryEntry(date: "2023-12-22"), selectedImages: []);
      expect(event.diaryData!, equals('2023-12-22'));
      expect(event.selectedImages, isEmpty);
    });

    test('DiaryBloc emits SuccessDiaryState on success', () async {
      final bloc = DiaryBloc();
      bloc.add(AddDiaryDataEvent(
          diaryData: DiaryEntry(date: "2023-12-22"), selectedImages: []));
      await expectLater(
        bloc.stream,
        emitsInOrder([isA<LoadingDiaryState>(), isA<SuccessDiaryState>()]),
      );
    });
  });
}
