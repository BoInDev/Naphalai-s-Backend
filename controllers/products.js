//CREATE
exports.create = async (req, res)=>{
        //Code
    try {
        const { name, price } = req.body
        console.log(name)
        res.send('CREATE')
    } catch(err){
        // Err
        console.log(err)
    }}
//LIST
exports.list = async (req, res)=>{
    try {
        res.send('LIST')
    } catch(err) {
        console.log(err)
    }}
//READ
exports.read = async (req, res)=>{
    try {
        res.send('READ')
    } catch(err) {
        console.log(err)
    }}
//UPDATE
exports.update = async (req, res)=>{
    try {
        res.send('UPDATE')
    } catch(err) {
        console.log(err)
    }}
//!DESTROY
exports.destroy = async (req, res)=>{
    try {
        res.send('DESTROY')
    } catch(err) {
        console.log(err)
    }
}