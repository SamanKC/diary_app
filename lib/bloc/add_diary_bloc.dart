import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:diary_app/models/diary_entry.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

part 'add_diary_event.dart';

part 'add_diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(InitialDiaryState()) {
    on<AddDiaryDataEvent>((event, emit) async {
      emit(LoadingDiaryState());
      try {
        final response = await _postDataToWebService(event.diaryData!);
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
    DiaryEntry? diaryData,
  ) async {
    final Uri apiUrl = Uri.parse('https://fakestoreapi.com/products');
    if (diaryData == null) {
      throw Exception('Invalid data or image');
    }

    try {
      if (diaryData.image != null) {
        final file = File(diaryData.image!);
        final List<int> imageBytes = await file.readAsBytes();
        final String base64Image = base64Encode(imageBytes);

        diaryData.image = base64Image;
      }
      final response = await http.post(
        apiUrl,
        body: jsonEncode(diaryData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return response;
      } else {
        throw ('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error posting data: $e');
    }
  }
}
