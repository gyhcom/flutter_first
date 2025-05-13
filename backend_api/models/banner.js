const mongoose = require('mongoose');

const bannerSchema = new mongoose.Schema({
    image: {
        type: String,
        required: true,
    }
})


const Banner = mongoose.model("Banner", bannerSchema); // 모델 스키마를 mongoose.Schema로 생성
module.exports = Banner;// / 모델을 export