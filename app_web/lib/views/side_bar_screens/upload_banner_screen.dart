import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '\banner-screen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text("Banners", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),)
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
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
                child:
                _image != null ? Image.memory(_image) : Text('카테고리 이미지'),
              ),
            ),

            ElevatedButton(onPressed: (){}, child: Text('저장') ),
          ],
        )


      ],


    );
  }
}
