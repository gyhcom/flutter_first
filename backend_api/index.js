// 📦 필요한 모듈 불러오기
const express = require("express");
const helloRoute = require("./routes/hello");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const bannerRouter = require("./routes/banner");
const categoryRouter = require("./routes/category");
const subCategoryRouter = require("./routes/sub_category");
const productRouter = require("./routes/product");
const productReviewRouter = require("./routes/product_review");
const cors = require("cors");
// 🔒 CORS 설정

// 🔧 서버 포트 번호 정의
const PORT = 3000;

// 🌐 MongoDB 연결 문자열 (MongoDB Atlas 사용)
const DB =
  "mongodb://gyh:rkddusgh12@localhost:27017/express?authSource=admin";

// 🚀 Express 애플리케이션 인스턴스 생성
const app = express();

// 🔗 CORS 미들웨어 등록
app.use(cors())

// 📥 JSON 요청 본문 파싱 미들웨어 등록
app.use(express.json());

// 🔐 인증 라우터 등록 (/api/signup 등 처리)
app.use(authRouter);

// 👋 기본 테스트용 라우터 등록 (helloRoute)
app.use(helloRoute);

// 📂 카테고리 관련 라우터 등록 (/api/category 등 처리
app.use(categoryRouter);
// 🖼️ 배너 관련 라우터 등록 (/api/banner 등 처리)
app.use(bannerRouter);

// 📂 서브 카테고리 관련 라우터 등록 (/api/sub_category 등 처리
app.use(subCategoryRouter);

// 📦 상품 관련 라우터 등록 (/api/product 등 처리
app.use(productRouter);

// ⭐ 상품 리뷰 관련 라우터 등록 (/api/product-review 등 처리
app.use(productReviewRouter);



// 🔗 MongoDB와 연결
mongoose.connect(DB).then(() => {
  console.log("MongoDB connected");
});

// 🖥️ 서버 실행 및 요청 수신 대기 시작
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
