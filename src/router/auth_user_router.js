const {Router} = require("express");
const router = Router();

const register = require("../auth/register/register");
const login = require("../auth/login/login");

// Login route
router.post("/login", login.loginUser);
// Register route
router.post("/register", register.registerUser);



module.exports = router;