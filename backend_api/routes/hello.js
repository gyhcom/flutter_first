const express = require("express");
const helloRoute = express.Router();
helloRoute.get("/hello", (req, res) => {
  // 클라이언트가 /hello 경로로 GET 요청을 보냈을 때 실행되는 핸들러
  // 응답으로 "Hello World!" 문자열을 전송
  res.send("Hello World11!");
});

module.exports = helloRoute;
