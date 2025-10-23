import 'dart:convert';

import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variable.dart';

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("ducobtxxe", "ymg0fxf2");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'banners',
        ),
      );

      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: "", image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
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
          ).showSnackBar(SnackBar(content: Text('배너가 성공적으로 업로드되었습니다.')));
        },
      );
    } catch (e) {
      print(e);
    }
    //fetch banners
    Future<List<BannerModel>> loadBanners() async {
      try {
        //send an http get request to fetch banners
        http.Response response = await http.get(
          Uri.parse("$uri/api/banner"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        print(response.body);
        if (response.statusCode == 200) {
          //ok
          List<dynamic> data = jsonDecode(response.body);
          List<BannerModel> banners =
          data.map((banner) => BannerModel.fromJson(banner)).toList();
          return banners;
        } else {
          throw Exception('배너를 불러오는 데 실패했습니다.');
        }
      } catch (e) {
        throw Exception('배너를 불러오는 데 실패했습니다.');
      }
    }
  }

  //fetch banner
}
