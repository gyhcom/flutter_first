const express = require("express");// User 모델을 가져옵니다.
const User = require("../models/user");// express 모듈을 가져옵니다.
const bcrypt = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');// 회원가입 라우터를 정의합니다.POST 요청을 처리하는 "/api/signup" 경로를 정의합니다.클라이언트가 회원가입 정보를 전송하면 이 핸들러가 실행됩니다.
authRouter.post("/api/signup", async (req, res) => {

  // 클라이언트가 전송한 회원가입 정보를 req.body에서 가져옵니다.fullname, email, password를 추출합니다.
  try {
    const { fullname, email, password } = req.body;
    const existingEmail = await User.findOne({ email });// 이메일이 이미 존재하는지 확인합니다.
    if (existingEmail) {// 이메일이 이미 존재하면 400 상태 코드와 함께 에러 메시지를 반환합니다.
      return res
        .status(400)
        .json({ msg: "이메일을 가진 사용자가 존재합니다." });
    } else {

      const salt = await bcrypt.genSalt(10)
      // 비밀번호 해시 속도? 그런건데 이게 20으로 하면
      // 로그인할때 시간이 엄청 오래걸림..암호화를 어렵게 해서 그런가

      hashedPassword = await bcrypt.hash(password, salt);
      let user = new User({ fullname, email, password: hashedPassword });
      user = await user.save();
      res.json({ user }); // 사용자 정보를 반환합니다.
    }
  console.timeEnd("전체 회원 로그입 ")
  } catch (error) {
    return res.status(500).json({ error: error.message });// 에러가 발생하면 500 상태 코드와 함께 에러 메시지를 반환합니다.
  }
});

module.exports = authRouter;
// 이 라우터를 사용하여 회원가입 기능을 구현할 수 있습니다.
// --------------------------------------------
// ❗ 내가 실수한 부분 요약:
// 1. `new User(...).save()`를 한 줄에서 즉시 저장했는데,
//    그걸 또 `await user.save()`로 저장해서 **두 번 저장을 시도**함.
//    → 해결 방법: 아래처럼 한 번만 저장하면 됨
//
//      const user = new User({ ... });
//      const savedUser = await user.save();
//
// 2. `var` 대신 `let` 또는 `const`를 사용하는 것이 일반적으로 더 안전함
// --------------------------------------------

authRouter.post("/api/login", async (req, res) => {
 console.time("로그인 소요 시간");
  try {
    const { email, password } = req.body;

    console.time("User.findOne 소요 시간");
    const user = await User.findOne({ email });
    console.timeEnd("User.findOne 소요 시간");

    if (!user) {
      console.timeEnd("전체 로그인 소요 시간");
      return res.status(400).json({ msg: "가입한 사용자가 없습니다." });
    }

    console.time("bcrypt.compare 소요 시간");
    const isMatch = await bcrypt.compare(password, user.password);
    console.timeEnd("bcrypt.compare 소요 시간");

    if (!isMatch) {
      console.timeEnd("전체 로그인 소요 시간");
      return res.status(400).json({ msg: "패스워드가 일치하지 않습니다." });
    }

    console.time("JWT.sign 소요 시간");
    const token = jwt.sign({ id: user._id }, "passwordKey");
    console.timeEnd("JWT.sign 소요 시간");

    const { password: _password, ...userWithoutPassword } = user._doc;
    
    console.timeEnd("전체 로그인 소요 시간");
    return res.json({ token, ...userWithoutPassword });
  } catch (error) {
    console.timeEnd("전체 로그인 소요 시간");
    return res.status(500).json({ error: error.message });
  }
}
);
// 이 라우터를 사용하여 로그인 기능을 구현할 수 있습니다.