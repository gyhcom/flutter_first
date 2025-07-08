import 'package:app_web/global_variable.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      // 이미지와 배너가 선택되었는지 확인
      if (pickedImage == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('카테고리 이미지를 선택해주세요.')));
        return;
      }

      if (pickedBanner == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('카테고리 배너를 선택해주세요.')));
        return;
      }

      final cloudinary = CloudinaryPublic('dmw9txkjr', 'ymg0fxf2');

      //upload image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'categoryImages',
        ),
      );

      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedBanner,
          identifier: 'pickedBanner',
          folder: 'categoryBanners',
        ),
      );
      String banner = bannerResponse.secureUrl;
      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/category"),
        body: category.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('카테고리가 성공적으로 업로드되었습니다!')));
        },
      );
    } catch (e) {
      print('Error uploading category: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('카테고리 업로드 중 오류가 발생했습니다: $e')));
    }
  }
}
