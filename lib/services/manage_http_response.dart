import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void ManageHttpResponse({
  required http.Response response, // HTTP 응답
  required BuildContext
  context, // BuildContext는 Flutter의 UI 트리에서 현재 위치를 나타내는 객체
  required Function onSuccess, // 성공 시 호출할 콜백 함수
}) {
  switch (response.statusCode) {
    case 200: // 성공
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['msg']); // 잘못된 요청
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['msg']); // 서버 오류
      break;
    case 201:
      showSnackBar(context, json.decode(response.body)['msg']); // 회원가입 성공
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
// SnackBar: Flutter에서 사용자에게 간단한 메시지를 표시하는 위젯