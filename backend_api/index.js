// express 모듈 불러오기
const express = require("express");

// 서버가 요청을 수신할 포트 번호 정의
const PORT = 3000;

// express 애플리케이션 인스턴스 생성
// 이 인스턴스를 통해 라우팅, 미들웨어 설정 등을 할 수 있음
const app = express();

// 지정한 포트로 서버 시작 및 요청 수신 대기
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
