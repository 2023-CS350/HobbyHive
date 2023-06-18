import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/widgets/loading_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  bool _isLoading = false;
  var _image = null;
  DateTime? _selectedDate = DateTime.now();
  TextEditingController _eventNameController = TextEditingController();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: _isLoading
          ? LoadingIndicator()
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        elevation: 5.0,
                        child: InkWell(
                          onTap: _getPhotoLibraryImage,
                          child: Container(
                            width: 150,
                            height: 200,
                            child: _image == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 100,
                                )
                              : Image.file(_image!,fit:BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _eventNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.title), // 이벤트 아이콘 추가
                        hintText: 'Event Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.white, // 테두리 색상을 흰색으로 설정
                          ),
                        ),
                      ),
                    ),

                    // ElevatedButton(
                    //   child: const Text("Select Date"),
                    //   onPressed: () async {
                    //     _selectedDate = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime.now(),
                    //       lastDate: DateTime.now().add(const Duration(days: 365)),
                    //     );
                    //     if (_selectedDate != null) {
                    //       _dateController.text =
                    //           _selectedDate.toString().split(' ')[0];
                    //     }
                    //   },
                    // ),
                    const SizedBox(height: 15),
                    TextField(
                      readOnly: true,
                      onTap: () async {
                        _selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (_selectedDate != null) {
                          _dateController.text =
                              _selectedDate.toString().split(' ')[0];
                        }
                      },
                      controller: _dateController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month), // 지도 아이콘 추가
                        hintText: 'Date',
          
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.white, // 테두리 색상을 흰색으로 설정
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.map), // 지도 아이콘 추가
                        hintText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.white, // 테두리 색상을 흰색으로 설정
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.description), // 지도 아이콘 추가
                        hintText: 'Event description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.white, // 테두리 색상을 흰색으로 설정
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: const Text('Create'),
                      onPressed: () async {
                        final FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        CollectionReference events =
                            firestore.collection('events');
                        setState(() {
                          _isLoading = true;
                        });
                        var uuid = Uuid();
                        var hostID = FirebaseAuth.instance.currentUser!.uid;
                        String randomUuid = uuid.v4();
          
                        try {
                          await firebase_storage.FirebaseStorage.instance
                              .ref('events/$randomUuid')
                              .putFile(_image);
          
                          // 업로드된 파일의 URL 얻어오기
                          String downloadURL = await firebase_storage
                              .FirebaseStorage.instance
                              .ref('events/$randomUuid')
                              .getDownloadURL();
          
                          print(downloadURL); // 파일의 URL을 출력
                        } on FirebaseException catch (e) {
                          // 업로드 또는 URL 얻어오기 중에 발생한 에러 처리
                          print(e);
                        }
                        await events.add({
                          'event_name': _eventNameController.text,
                          'address': _locationController.text,
                          'description': _descriptionController.text,
                          'date': _selectedDate, // 현재 시간을 Timestamp로 저장
                          'event_image': randomUuid,
                          'host_id': hostID,
                        }).then((value) {
                          print("이벤트가 추가되었습니다.");
                          Navigator.pop(context);
                        }).catchError(
                          (error) => print("문서 추가 중 오류가 발생했습니다: $error"),
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
          ),
    );
  }

  _getPhotoLibraryImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
