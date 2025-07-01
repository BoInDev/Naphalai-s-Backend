const connection = require('../../../connection/database_connection');
const jwt = require('jsonwebtoken');
const secretkey = process.env.secretkey || "naphalai@888";
const path = require('path');
const fs = require('fs');
const multer = require('multer');

// Multer setup for image upload
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadPath = path.join(__dirname, '../../../uploads/products');
    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }
    cb(null, uploadPath);
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname);
  },
});
const upload = multer({ storage: storage });

const addProduct = (req, res) => {
  // JWT verify inside API
  const bearerHeader = req.headers['authorization'];
  if (!bearerHeader) {
    return res.status(403).json({ success: false, message: 'No token provided' });
  }
  const bearer = bearerHeader.split(' ');
  const token = bearer[1];
  jwt.verify(token, secretkey, (err, decoded) => {
    if (err) {
      return res.status(403).json({ success: false, message: 'Token invalid or expired' });
    }
    // Map request body to match tb_products table structure
    const { name, sku, price, desciprion, summary, categories_id } = req.body;
    // Handle image upload
    let image = null;
    if (req.file) {
      image = `/uploads/products/${req.file.filename}`;
    }
    // Check if product with the same sku already exists
    const checkQuery = 'SELECT * FROM tb_products WHERE sku = ?';
    connection.query(checkQuery, [sku], (err, results) => {
      if (err) {
        return res.status(500).json({ success: false, message: 'Database error', error: err });
      }
      if (results.length > 0) {
        // Product already exists
        return res.status(409).json({ success: false, message: 'Product with this SKU already exists' });
      } else {
        // Insert new product into tb_products
        const insertQuery = `
          INSERT INTO tb_products 
          (name, sku, price, desciprion, summary, image, categories_id) 
          VALUES (?, ?, ?, ?, ?, ?, ?)
        `;
        connection.query(
          insertQuery,
          [name, sku, price, desciprion, summary, image, categories_id],
          (err, result) => {
            if (err) {
              return res.status(500).json({ success: false, message: 'Failed to add product', error: err });
            }
            return res.status(201).json({ success: true, message: 'Product added successfully', product_id: result.insertId, image });
          }
        );
      }
    });
  });
}

const getAllProducts = (req, res) => {
  const bearerHeader = req.headers['authorization'];
  if (!bearerHeader) {
    return res.status(403).json({ success: false, message: 'No token provided' });
  }

  const bearer = bearerHeader.split(' ');
  const token = bearer[1];

  jwt.verify(token, secretkey, (err, decoded) => {
    if (err) {
      return res.status(403).json({ success: false, message: 'Token invalid or expired' });
    }

    const query = 'SELECT * FROM tb_products';
    connection.query(query, (err, results) => {
      if (err) {
        return res.status(500).json({ success: false, message: 'Database error', error: err });
      }

      // ✅ Return using 'data' key instead of 'products'
      return res.status(200).json({ success: true, data: results });
    });
  });
};


const getOneProduct = (req, res)=>{
  const {id} = req.body;
  jwt.verify(req.token, secretkey, (err, decoded) => {
    if (err) {
      return res.status(403).json({ success: false, message: 'Token invalid or expired' });
    }
    // Fetch product by ID
    const query = 'SELECT * FROM tb_products WHERE id = ?';
    connection.query(query, [id], (err, results) => {
      if (err) {
        return res.status(500).json({ success: false, message: 'Database error', error: err });
      }
      if (results.length === 0) {
        return res.status(404).json({ success: false, message: 'Product not found' });
      }
      return res.status(200).json({ success: true, product: results[0] });
    });
  })
}

module.exports = {
  addProduct,
  upload,
  getAllProducts,
  getOneProduct
};