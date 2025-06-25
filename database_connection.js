const express = require('express')
const app = express()
const mysql = require('mysql2')

const { readdirSync } = require('fs')

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'naphalai'
})

connection.connect((err) => {
    if (err) throw err
    console.log('Connected to MySQL Database!')

    connection.query('SELECT * FROM tb_users', (err, results, field) => {
        if (err) throw err
        console.log(results)
    })
    connection.end()
})

readdirSync('./routers').map((c) => app.use('/api', require('./routers/' + c)))

app.listen(3000, () => {
    console.log('Server is running on port 3000')
})
