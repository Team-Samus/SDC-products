const express = require('express');
//  const cors = require('cors');
const routes = require('./routes')

const app = express();
const port = 3000;

app.use(express.json());
// app.get('/products', (req, res) => {
//   console.log(res)
//   res.send('ty walter');
// })
app.use(routes.getProducts)

app.listen(port, () => console.log(`Listening on port ${port}`));