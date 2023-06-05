import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => _getPhotoLibraryImage(),
              iconSize: 100,
            ),
            TextField(
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
            const SizedBox(height: 15),
            ElevatedButton(
              child: const Text("Select Date"),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (selectedDate != null) {
                  // todo
                }
              },
            ),
            const SizedBox(height: 15),
            TextField(
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
              onPressed: () {
                // Add your logic for creating the event here
              },
            ),
          ],
        ),
      ),
    );
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        //todo
      });
    }
  }
}
