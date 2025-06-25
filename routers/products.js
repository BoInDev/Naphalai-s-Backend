const express = require("express")
const router = express.Router()

const { create } = require('../controllers/products')
const { read } = require('../controllers/products')
const { list } = require('../controllers/products')
const { update } = require('../controllers/products')
const { destroy } = require('../controllers/products')

router.get('/product', list);
router.get('/product/:productId', read);
router.post('/product', create);
router.put('/product/:productId', update);
router.delete('/product/:productId', destroy);

module.exports = router