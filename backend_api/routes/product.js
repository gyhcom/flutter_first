const express = require('express');
const Product = require('../models/product');
const productRouter = express.Router();

productRouter .post('/api/add-product', async (req, res) => {
 try{
    const {productName, productPrice, quantity, description, category, subCategory, images} = req.body;
    const product = new Product({
        productName, productPrice, quantity, description, category, subCategory, images
    })

    await product.save();
    return res.status(201).send(product);
 }catch(e){
     res.status(500).json({error: e.message});
 }
});

productRouter.get('/api/popular-products', async (req, res) => {
    try {
        const products = await Product.find({ popular: true });
        if (!products || products.length === 0) {
            return res.status(404).json({ msg: "인기 상품이 없습니다." });
        } else {
            res.status(200).json({ products });
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get('/api/recommended-products', async (req, res) => {
    try {
        const products = await Product.find({ recommend: true });
        if (!products || products.length === 0) {
            return res.status(404).json({ msg: "추천 상품이 없습니다." });
        } else {
            res.status(200).json({ products });
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;