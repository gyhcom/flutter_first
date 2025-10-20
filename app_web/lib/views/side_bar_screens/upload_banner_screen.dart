import 'package:app_web/controllers/banner_controller.dart';
import 'package:app_web/views/side_bar_screens/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '\banner-screen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
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
              "Banners",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
          ),
        ),
        Divider(color: Colors.grey, thickness: 1),

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

            ElevatedButton(
              onPressed: () async {
                await _bannerController.uploadBanner(
                  pickedImage: _image,
                  context: context,
                );
              },
              child: Text('저장'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: pickImage, child: Text('이미지 선택하기')),
        ),
        Divider(color: Colors.grey),
        BannerWidget(),
      ],
    );
  }
}
