import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  dynamic _image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(color: Colors.grey),
        ),

        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: _image != null ? Image.memory(_image) : Text('카테고리 이미지'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(labelText: '카테고리 이름 입력'),
                ),
              ),
            ),

            TextButton(onPressed: () {}, child: Text('cancle')),
            ElevatedButton(onPressed: () {}, child: Text('Save')),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: Text('Pick Image'),
          ),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
