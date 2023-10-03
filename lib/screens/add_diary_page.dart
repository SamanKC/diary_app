import 'dart:io';

import 'package:diary_app/bloc/add_diary_bloc.dart';
import 'package:diary_app/constants/colors.dart';
import 'package:diary_app/constants/fonts.dart';
import 'package:diary_app/widgets/elevated_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  final List<String> dateOptions = ['2023-12-22', 'Date 1', 'Date 2'];
  final List<String> areaOptions = ['Select Area', 'Area 1', 'Area 2'];
  final List<String> taskCategoryOptions = [
    'Task Category',
    'Category 2',
    'Category 3'
  ];
  final List<String> eventOptions = ['Select an event', 'Event 1', 'Event 2'];

  String selectedDate = '2023-12-22';
  String selectedArea = 'Select Area';
  String selectedTaskCategory = 'Task Category';
  String selectedEventOptions = 'Select an event';
  TextEditingController tagsController = TextEditingController();

  List<XFile> selectedImages = [];
  Future<void> _addPhoto() async {
    final imagePicker = ImagePicker();
    final images = await imagePicker.pickMultiImage();

    if (images != null) {
      setState(() {
        selectedImages.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Diary")),
      body: BlocListener<DiaryBloc, DiaryState>(
        listener: (context, state) {
          if (state is SuccessDiaryState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Success")));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  children: [
                    Icon(Icons.location_pin),
                    Text(
                      "2004|TAP NS, Nepal, Morang",
                      style: TextStyle(fontSize: normalText),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add to site diary",
                          style: TextStyle(fontSize: headingText),
                        ),
                        Icon(
                          Icons.help,
                          color: textBlackShade,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedContainer(
                      title: 'Add Photos to site diary',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          selectedImages.isNotEmpty
                              ? SizedBox(
                                  height: 150.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: selectedImages.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.file(
                                                    File(selectedImages[index]
                                                        .path),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: -10,
                                              child: SizedBox(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedImages
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          blackColor,
                                                      shape:
                                                          const CircleBorder(),
                                                      minimumSize:
                                                          const Size(24, 24)),
                                                  child: const Icon(
                                                    Icons.close,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          ElevatedButton(
                            onPressed: _addPhoto,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: buttonColor),
                            child: const Text('Add Photo'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: buttonColor,
                            value: true,
                            onChanged: (value) {},
                            title: const Text(
                              "Include in photo gallery",
                              style: TextStyle(color: textBlackShade),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedContainer(
                      title: 'Comments',
                      content: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Comments',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedContainer(
                      title: 'Details',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            isExpanded: true,
                            value: selectedDate,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                selectedDate = value!;
                              });
                            },
                            items: dateOptions.map((date) {
                              return DropdownMenuItem<String>(
                                value: date,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    date,
                                    style:
                                        const TextStyle(color: textBlackShade),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16.0),
                          DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: selectedArea,
                            onChanged: (value) {
                              setState(() {
                                selectedArea = value!;
                              });
                            },
                            items: areaOptions.map((area) {
                              return DropdownMenuItem<String>(
                                value: area,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    area,
                                    style:
                                        const TextStyle(color: textBlackShade),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16.0),
                          DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: selectedTaskCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedTaskCategory = value!;
                              });
                            },
                            items: taskCategoryOptions.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category,
                                    style:
                                        const TextStyle(color: textBlackShade),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: tagsController,
                            decoration: const InputDecoration(
                              labelText: ' Tags',
                              labelStyle: TextStyle(color: textBlackShade),
                              contentPadding: EdgeInsets.all(12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedContainer(
                      titleWidget: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: buttonColor,
                        value: true,
                        onChanged: (value) {},
                        title: const Text(
                          "Link to existing event?",
                          style: TextStyle(color: textBlackShade),
                        ),
                      ),
                      content: DropdownButton<String>(
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: selectedEventOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedEventOptions = value!;
                          });
                        },
                        items: eventOptions.map((event) {
                          return DropdownMenuItem<String>(
                            value: event,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                event,
                                style: const TextStyle(color: textBlackShade),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        final diaryData = {
                          'date': selectedDate,
                          'area': selectedArea,
                          'taskCategory': selectedTaskCategory,
                          'tags': tagsController.text,
                        };

                        final addDiaryEvent = AddDiaryDataEvent(
                          diaryData: diaryData,
                          selectedImages: selectedImages,
                        );

                        context.read<DiaryBloc>().add(addDiaryEvent);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: buttonColor),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
