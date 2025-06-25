const express = require('express')
const app = express()
const morgan = require('morgan')
const bodyParser = require('body-parser')
const cors = require('cors')
// const mysql = require('mysql2/promise')
const mysql = require('mysql2')

const { readdirSync } = require('fs')

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'naphalai'
})

connection.connect((err)=>{
    if (err) throw err
    console.log('Connected to MySQL Database!')

    connection.query('SELECT * FROM tb_users', (err, results, field)=> {
        if (err) throw err
        console.log(results)
    })
    connection.end()
})

//  Promise-based connection to MySQL
// async function main () {
//     try {
//         const connection = await mysql.createConnection({
//             host: 'localhost',
//             user: 'root',
//             password: '',
//             database: 'naphalai'
//         })

//         console.log('Connected to MySQL Database!')

//         const [rows, fields] = await connection.execute('SELECT * FROM tb_users')
//         console.log('Query Results: ', rows)

//         await connection.end()
//     } catch (err) {
//         console.error('Error', err)
//     }
// }
// main();

// Middleware
// app.use(morgan('dev'))
// app.use(bodyParser.json())
// app.use(cors())

readdirSync('./routers').map((c)=>app.use('/api', require('./routers/'+c)))


app.listen(5000, ()=> console.log('Server is running on port 5000'))