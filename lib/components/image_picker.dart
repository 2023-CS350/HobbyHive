import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: imageSize,
                minWidth: imageSize,
              ),
              child: GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: Center(
                  child: Icon(
                    Icons.account_circle,
                    size: imageSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('라이브러리에서 불러오기'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
