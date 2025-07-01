const connection = require('../../../connection/database_connection');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secretkey = process.env.secretkey || "naphalai@888" 



const loginUser = async (req, res) =>{
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ message: 'do not have username and password' });
    }
    if (username.length < 3 || password.length < 6) {
        return res.status(400).json({ message: 'username or password is too short' });
    }
    try {
        const loginUser = 'SELECT * FROM tb_users WHERE username = ?';
        connection.query(loginUser, [username], async (error, results) => {
            if (error) {
                return res.status(500).json({ message: 'Database error', error });
            }
            if (results.length === 0) {
                return res.status(401).json({ message: 'Invalid username or password' });
            }

            const user = results[0];
            const isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch) {
                return res.status(401).json({ message: 'Invalid username or password' });
            }

            const token = jwt.sign({ userId: user.id }, secretkey, { expiresIn: '1h' });
            res.json({ token, userId: user.id, username: user.username });
        });
    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ message: 'Internal server error' });
    }


    
}



module.exports = {
loginUser
}