const connection = require('../../../connection/database_connection');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secretkey = process.env.secretkey || "naphalai@888" 


const registerUser = async (req, res) => {
    const { username, password, phone_number, email,  } = req.body;
    if (!username || !password || !phone_number || !email) {
        return res.status(400).json({ message: 'All fields are required' });
    }
    if (username.length < 3 || password.length < 6) {
        return res.status(400).json({ message: 'Username or password is too short' });
    }
    try {
        const checkUserQuery = 'SELECT * FROM tb_users WHERE username = ?';
        connection.query(checkUserQuery, [username], async (error, results) => {
            if (error) {
                return res.status(500).json({ message: 'Database error', error });
            }
            if (results.length > 0) {
                return res.status(409).json({ message: 'Username already exists' });
            }

            const hashedPassword = await bcrypt.hash(password, 10);
            const insertUserQuery = 'INSERT INTO tb_users (username, password, phone_number, email) VALUES (?, ?, ?, ?)';
            connection.query(insertUserQuery, [username, hashedPassword, phone_number, email], (insertError, insertResults) => {
                if (insertError) {
                    return res.status(500).json({ message: 'Database error', insertError });
                }

                const token = jwt.sign({ userId: insertResults.insertId }, secretkey, { expiresIn: '1h' });
                res.json({ token, userId: insertResults.insertId, username });
            });
        });
    } catch (error) {
        console.error('Registration error:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
};






module.exports = {
registerUser
};