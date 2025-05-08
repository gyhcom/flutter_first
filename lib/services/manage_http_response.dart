import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void ManageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required Function onSuccess,
}) {
  final resBody = json.decode(response.body);
  final msg = resBody['msg'] ?? resBody['message'] ?? 'Something went wrong';

  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;

    case 201: // 예: 회원가입 성공 메시지
    case 400: // 잘못된 요청 (이메일 형식 등)
    case 500: // 서버 에러
      showSnackBar(context, msg);
      break;

    default:
      // 예외 상태 코드 (403, 404 등)
      showSnackBar(context, msg);
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
// SnackBar: Flutter에서 사용자에게 간단한 메시지를 표시하는 위젯