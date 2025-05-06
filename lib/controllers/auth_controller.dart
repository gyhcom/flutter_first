import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store_app/global_variables.dart';
import 'package:store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/services/manage_http_response.dart';

class AuthController {
  Future<void> signUpUsers({
    required context, // Flutter의 UI 트리에서 현재 위치를 나타내는 객체
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
      );
      print(user.toJson());
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'), //아 이게 저번에 로컬쪽 세팅하는거였는데 내가 안함 에러 맞음
        body: user.toJson(), // User 객체를 JSON 문자열로 변환
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      ManageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "회원가입 성공");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      print("📤 로그인 요청 보냄");
      print("📧 email: $email");
      print("🔐 password: $password");

      http.Response response = await http.post(
        Uri.parse("$uri/api/login"), // 로그인 API URL
        body: jsonEncode({
          'email': email, // 이메일
          'password': password, // 비밀번호
        }),
        headers: <String, String>{
          // 요청 헤더
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("📥 응답 상태 코드: ${response.statusCode}");
      print("📥 응답 본문: ${response.body}");

      ManageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          print("✅ onSuccess 콜백 호출됨");
          showSnackBar(context, "로그인 성공"); // 로그인 성공 시 처리
        },
      );
      // 응답 처리
    } catch (e) {
      print(e);
    }
  }
}
