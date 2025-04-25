const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  // 사용자 이름을 저장하는 필드
  fullname: {
    type: String,
    required: true, // 필수 입력
    trim: true,
  },
  // 사용자 이메일을 저장하는 필드
  email: {
    type: String,
    required: true, // 필수 입력
    unique: true, // 고유한 값이어야 함
    trim: true,
    validate: {
      validator: (value) => {
        // 이메일 형식 검증
        const result =
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return result.test(value);
      },
      message: "Please enter a valid email address", // 이메일 형식이 잘못된 경우의 에러 메시지
    },
  },

  state: {
    type: String,
    default: "",
  },

  city: {
    type: String,
    default: "",
  },

  locality: {
    type: String,
    default: "",
  },
  // 사용자 비밀번호를 저장하는 필드
  password: {
    type: String,
    required: true, // 필수 입력
    validate: {
      validator: (value) => {
        // 비밀번호 길이 검증
        return value.length >= 8; // 최소 6자 이상
      },
      message: "Password must be at least 8 characters long", // 비밀번호 길이가 짧은 경우의 에러 메시지
    },
  },
});
// 사용자 스키마를 기반으로 모델 생성
const User = mongoose.model("User", userSchema);
// 모델을 내보내기
module.exports = User;
// 이 모델을 사용하여 MongoDB 데이터베이스와 상호작용할 수 있음
// 예를 들어, 사용자를 생성하거나 조회하는 등의 작업을 수행할 수 있음
// const mongoose = require("mongoose");
// const User = require("./models/user"); // 사용자 모델 불러오기
//
// // MongoDB에 연결
// mongoose
