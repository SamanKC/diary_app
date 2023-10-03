import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

part 'add_diary_event.dart';

part 'add_diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(InitialDiaryState()) {
    on<AddDiaryDataEvent>((event, emit) async {
      emit(LoadingDiaryState());
      try {
        final response = await _postDataToWebService(
            event.diaryData!, event.selectedImages!);
        if (response.statusCode > 200 && response.statusCode < 300) {
          emit(SuccessDiaryState());
        } else {
          emit(ErrorDiaryState('Failed to post data to the web service'));
        }
      } catch (e) {
        emit(ErrorDiaryState('An error occurred: $e'));
      }
    });
  }

  Future<http.Response> _postDataToWebService(
    Map<String, dynamic>? diaryData,
    List<XFile>? selectedImages,
  ) async {
    if (diaryData == null || selectedImages == null) {
      throw Exception('Invalid data or images');
    }

    final List<String> imageBase64List = [];
    for (final image in selectedImages) {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      imageBase64List.add(base64Image);
    }

    diaryData['images'] = imageBase64List;

    final Uri uri = Uri.parse('https://reqres.in/api/newdiary');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(diaryData),
    );

    return response;
  }
}
