const express = require('express');
const Banner = require('../models/banner');
const bannerRouter = express.Router();

bannerRouter.post('/api/banner', async (req, res) => {
    try {
        const {image} = req.body;
         const newBanner = new Banner({
            image
        });
        await newBanner.save();
        return res.status(201).send(newBanner);
    } catch (error) {
        res.status(400).json({error: error.message});
    }
});

module.exports = bannerRouter;