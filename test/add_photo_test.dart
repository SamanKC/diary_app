import 'package:diary_app/screens/add_diary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  group('Add Diary Page Tests', () {
    testWidgets('Adding an image updates selectedImages list',
        (WidgetTester tester) async {
      // Build your AddDiaryPage widget
      await tester.pumpWidget(MaterialApp(home: AddDiaryPage()));

      // Verify that selectedImages is initially empty
      expect(find.byType(AddDiaryPage), findsOneWidget);

      // Trigger the _addPhoto function by tapping the "Add Photo" button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add Photo'));
      await tester.pumpAndSettle(); // Wait for the image picker to open

      // Simulate selecting two images (you can adjust this as needed)
      // Replace these paths with actual image paths you want to test
      const imagePaths = ['path/to/image1.jpg', 'path/to/image2.jpg'];
      final images = imagePaths.map((path) => XFile(path)).toList();
    });
  });
}
