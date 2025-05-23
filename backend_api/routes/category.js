const express = require('express');
const Category = require('../models/category');

const categoryRouter = express.Router();

categoryRouter.post('/api/category', async(req, res) => {
    try{
        const {name, image, banner} = req.body;
        const category = new Category({
            name,image,banner
        });

        await category.save();
        res.status(201).json(category);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

categoryRouter.get('/api/category', async(req, res) => {
    try{
        const categories = await Category.find();
        return res.status(200).json({categories})
    } catch (e){
        res.status(500).json({error: e.message});
    }
});

module.exports =categoryRouter;