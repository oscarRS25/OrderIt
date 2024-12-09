import mysql from "promise-mysql";

const pool = mysql.createPool({
  host: "127.0.0.1",
  user: "root",
  password: "Root123.",
  database: "orderit",
});

pool.getConnection().then((connection) => {
  pool.releaseConnection(connection);
  console.log("DB is Connected");
});

export default pool;
