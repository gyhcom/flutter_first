const express = require('express');
const SubCategory = require('../models/sub_category');
const subCategoryRouter = express.Router();

subCategoryRouter.post('/api/sub_category', async (req, res) => {
    try{
        const {categoryId, categoryName, image, subCategoryName} = req.body;
        const subcategory = new SubCategory({
            categoryId, categoryName, image, subCategoryName
        });
        await subcategory.save();
        res.status(201).json(subcategory);
    } catch (e) {
        res.status(500).json({error: e.message})
    }
});


subCategoryRouter.post('/api/subcategories', async(req, res) =>{

});

subCategoryRouter.get('/api/category/:categoryName/subcategories', async (req, res) => {
    try {
        const {categoryName} = req.params;
    
        const subcategories = await SubCategory.find({categoryName: categoryName});
        
        // subcategories가 없거나 길이가 0인 경우
        if(! subcategories || subcategories.length ==0){
            return res.status(404).json({msg:"서브 카테고리가 없습니다."});    
        } else{
            res.status(200).json({subcategories});
        }
    } catch (e) {
        res.status(500).json({error: e.message});
    }

});
module.exports = subCategoryRouter;