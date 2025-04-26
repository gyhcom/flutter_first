// 📦 필요한 모듈 불러오기
const express = require("express");
const helloRoute = require("./routes/hello");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

// 🔧 서버 포트 번호 정의
const PORT = 3000;

// 🌐 MongoDB 연결 문자열 (MongoDB Atlas 사용)
const DB =
  "mongodb+srv://@cluster0.dipt9q7.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// 🚀 Express 애플리케이션 인스턴스 생성
const app = express();

// 📥 JSON 요청 본문 파싱 미들웨어 등록
app.use(express.json());

// 🔐 인증 라우터 등록 (/api/signup 등 처리)
app.use(authRouter);

// 👋 기본 테스트용 라우터 등록 (helloRoute)
app.use(helloRoute);

// 🔗 MongoDB와 연결
mongoose.connect(DB).then(() => {
  console.log("MongoDB connected");
});

// 🖥️ 서버 실행 및 요청 수신 대기 시작
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
