const express = require('express');
//const { Pool } = require('pg');
const jwt = require("jsonwebtoken");

const pool = require('./db');

require('dotenv').config();

const app = express();
app.use(express.json()); 

app.set("llaveprivadajwt","mi clave ultrasecreta.123");

const rutasProtegidas = express.Router(); 

rutasProtegidas.use((req, res, next) => {
    const token = req.headers['token-acceso'];

    if (token) {
      jwt.verify(token, app.get('llaveprivadajwt'), (err, decoded) => {      
        if (err) {
          return res.json({ mensaje: 'Token no valido' });    
        } else {
          req.decoded = decoded;    
          next();
        }
      });
    } else {
      res.send({ 
          mensaje: 'Token no proveído.' 
      });
    }
 });

 app.post('/login', async (req, res) => {
  const { Usuario, Contraseña } = req.body;

  try {
      const result = await pool.query('SELECT * FROM clientes WHERE Usuario = $1 and Contraseña = $2', [Usuario, Contraseña]);
      if (result.rows.length === 0) {
          return res.status(404).send('Usuario no encontrado');
      } else {
          // Obtener el primer cliente encontrado
          const cliente = result.rows[0];
          const ClienteId = cliente.clienteid; 
       
          const payload = {
              ClienteId: ClienteId,
              Usuario: Usuario
          };
          const token = jwt.sign(payload, app.get('llaveprivadajwt'), {
              expiresIn: '1d'
          });

          // Enviar la respuesta JSON con el token y el ClienteId
          res.json({
              token: token,
              ClienteId: ClienteId
          });
      }
  } catch (err) {
      console.error(err);
      res.status(500).send('Error interno');
  }
});


//listar clientes --------------------------------------------------------------
app.get("/clientes",rutasProtegidas, async (req,res )=>{
    try{
        const result = await pool.query("select * from Clientes");
        res.json(result.rows);    
       // pool.end();
    }catch(err){
        console.log(err);
        return res.status(500).send("Error de servidor")
    }
});
app.get('/clientes/:id', async (req, res) => {
    const { id } = req.params;
    try {
      const result = await pool.query('SELECT * FROM Clientes WHERE ClienteID = $1', [id]);
      if (result.rows.length === 0) {
        return res.status(404).send('Usuario no encontrado');
      }
      res.json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).send('Error interno');
    }
  });
//listar historial de pedidos por cliente
app.get("/historial/:clienteId", async (req, res) => {
  const { clienteId } = req.params;
  try {
    const result = await pool.query(
      `SELECT P.FechaPedido, Pr.Nombre, P.Total
       FROM Pedidos P
       JOIN DetallesPedido DP ON P.PedidoID = DP.PedidoID
       JOIN Productos Pr ON DP.ProductoID = Pr.ProductoID
       WHERE P.ClienteID = $1`,
      [clienteId]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send("Error de servidor");
  }
});

//insertar
 app.post('/clientes', async (req, res) => {
    const {Usuario,Contraseña } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO Clientes (Usuario, Contraseña) VALUES ($1, $2) RETURNING *',
        [Usuario,Contraseña]
      );
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).send('Error de servidor');
    }
  });

  //listar productos --------------------------------------------------------------
app.get("/productos", async (req,res )=>{
  try{
      const result = await pool.query("select * from Productos");
      res.json(result.rows);    
  }catch(err){
          console.log(err);
          return res.status(500).send("Error de servidor")
  }
});

app.get('/productos/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query('SELECT * FROM Productos WHERE CategoriaID  = $1', [id]);
    if (result.rows.length === 0) {
      return res.status(404).send('Producto no encontrado');
    }
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error interno');
  }
});
 //listar pedidos --------------------------------------------------------------
 app.get("/pedidos", async (req, res) => {
  try {
      const result = await pool.query("SELECT * FROM Pedidos");
      res.json(result.rows);
  } catch (err) {
      console.error(err);
      return res.status(500).send("Error de servidor");
  }
});
app.get('/pedidos/:id', async (req, res) => {
  const { id } = req.params;
  try {
      const result = await pool.query('SELECT * FROM Pedidos WHERE PedidoID = $1', [id]);
      if (result.rows.length === 0) {
          return res.status(404).send('Pedido no encontrado');
      }
      res.json(result.rows[0]);
  } catch (err) {
      console.error(err);
      res.status(500).send('Error interno');
  }
});
//insertar
app.post('/pedidos', async (req, res) => {
  const { ClienteID, Direccion, Total, Estado } = req.body;
  try {
      const result = await pool.query(
          'INSERT INTO Pedidos (ClienteID, Direccion, Total, Estado) VALUES ($1, $2, $3, $4) RETURNING *',
          [ClienteID, Direccion, Total, Estado]
      );
      res.status(201).json(result.rows[0]);
  } catch (err) {
      console.error(err);
      res.status(500).send('Error de servidor');
  }
});
//listar detalles pedidos --------------------------------------------------------------
app.get("/detallespedido", async (req, res) => {
  try {
      const result = await pool.query("SELECT * FROM DetallesPedido");
      res.json(result.rows);
  } catch (err) {
      console.error(err);
      return res.status(500).send("Error de servidor");
  }
});
app.get('/detallespedido/:id', async (req, res) => {
  const { id } = req.params;
  try {
      const result = await pool.query('SELECT * FROM DetallesPedido WHERE DetalleID = $1', [id]);
      if (result.rows.length === 0) {
          return res.status(404).send('Detalle de pedido no encontrado');
      }
      res.json(result.rows[0]);
  } catch (err) {
      console.error(err);
      res.status(500).send('Error interno');
  }
});
//insertar
app.post('/detallespedido', async (req, res) => {
  const { PedidoID, ProductoID, Cantidad, PrecioUnitario } = req.body;
  try {
      const result = await pool.query(
          'INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad, PrecioUnitario) VALUES ($1, $2, $3, $4) RETURNING *',
          [PedidoID, ProductoID, Cantidad, PrecioUnitario]
      );
      res.status(201).json(result.rows[0]);
  } catch (err) {
      console.error(err);
      res.status(500).send('Error de servidor');
  }
});


var server = app.listen(3200,function(){
    console.log("el servidor express se encuentra en ejecucion");
});