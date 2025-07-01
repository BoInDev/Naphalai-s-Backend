const express = require('express');
const router = express.Router();
const jwt = require("jsonwebtoken");
const secretkey = process.env.secretkey || "naphalai@888" 

// product 
const productRouter = require('../masterdata/product/product');
const connection = require('../../connection/database_connection');
router.post('/add/product',user_verifyToken, productRouter.upload.single('image'), productRouter.addProduct);
router.get('/get/all/product', user_verifyToken, productRouter.getAllProducts);
router.get('/get/one/product', user_verifyToken, productRouter.getOneProduct);


//






function admin_verifyToken(req, res, next) {
  // Get auth header value
  const bearerHeader = req.headers['authorization'];

  // Check if bearer is undefined
  if (typeof bearerHeader !== 'undefined') {
    // Split at the space
    const bearer = bearerHeader.split(' ');
    // Get token from array
    const bearerToken = bearer[1];

    // Verify the token
    jwt.verify(bearerToken,secretkey, (err, decoded) => {
      if (err) {
        return res.sendStatus(403); // Invalid token
      }

      // Check role from decoded token
      if (decoded.role !== 'admin') {
        return res.status(403).json({ message: 'Access denied: Admins only' });
      }
      // Set the token and decoded user
      req.token = bearerToken;
      req.user = decoded;

      // Continue to next middleware or route
      next();
    });

  } else {
    // Forbidden: No token provided
    res.sendStatus(403);
  }
}

function user_verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];
  if (typeof bearerHeader !== 'undefined') {
    const bearer = bearerHeader.split(' ');
    const bearerToken = bearer[1];

    jwt.verify(bearerToken, secretkey, (err, decoded) => {
      if (err) {
        return res.status(403).json({ resultCode: "Token invalid or expired" });
      }

      // Use correct field for user id
      const userId = decoded.userId || decoded.id || decoded.userid || decoded.ID;
      if (!userId) {
        return res.status(403).json({ resultCode: "Invalid token payload" });
      }

      // Check user status by user id, not by user_status_id
      const check_user_status_query = "SELECT * FROM tb_users WHERE id = ?";
      connection.query(check_user_status_query, [userId], (error, results) => {
        if (error) {
          return res.status(500).json({ resultCode: "Error checking user status" });
        }
        if (results.length === 0) {
          return res.status(404).json({ resultCode: "User not found" });
        }

        if (results[0].user_status_id !== 1) {
          return res.status(403).json({ resultCode: "ບັນຊີນີ້ຖືກປິດໃຊ້ງານ" });
        }

        req.token = bearerToken;
        req.user = decoded;
        next();
      });
    });
  } else {
    res.sendStatus(403);
  }
}


module.exports = router; 