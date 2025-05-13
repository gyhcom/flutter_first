// 📦 필요한 모듈 불러오기
const express = require("express");
const helloRoute = require("./routes/hello");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const bannerRouter = require("./routes/banner");

// 🔧 서버 포트 번호 정의
const PORT = 3000;

// 🌐 MongoDB 연결 문자열 (MongoDB Atlas 사용)
const DB =
  "mongodb://gyh:rkddusgh12@localhost:27017/express?authSource=admin";

// 🚀 Express 애플리케이션 인스턴스 생성
const app = express();

// 📥 JSON 요청 본문 파싱 미들웨어 등록
app.use(express.json());

// 🔐 인증 라우터 등록 (/api/signup 등 처리)
app.use(authRouter);

// 👋 기본 테스트용 라우터 등록 (helloRoute)
app.use(helloRoute);

// 🖼️ 배너 관련 라우터 등록 (/api/banner 등 처리)
app.use(bannerRouter);

// 🔗 MongoDB와 연결
mongoose.connect(DB).then(() => {
  console.log("MongoDB connected");
});

// 🖥️ 서버 실행 및 요청 수신 대기 시작
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
