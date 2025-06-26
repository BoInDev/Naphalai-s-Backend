function verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];
  if (typeof bearerHeader !== 'undefined') {
    const bearer = bearerHeader.split(' ');
    const bearerToken = bearer[1];
    
    jwt.verify(bearerToken, secretkey, (err, decoded) => {
      if (err) {
        return res.status(403).json({ resultCode: "TokenError", message: "Token verification failed" });
      }

      const userId = decoded.user_id;

      connected.query(queries.check_user_status_id ,[userId],
        (error, results) => {
          if (error || results.length === 0) {
            return res.status(500).json({ resultCode: "Error checking user status" });
          }

          if (results[0].user_status_id !== 1) {
            return res.status(403).json({ resultCode: "ບັນຊີນີ້ຖືກປິດໃຊ້ງານ" });
          }

          req.token = bearerToken;
          req.user = decoded;
          next();
        }
      );
    });
  } else {
    res.status(403).json({ resultCode: "TokenError", message: "No token provided" });
  }
}

module.exports = {
  verifyToken
};
///