import mysql from 'promise-mysql';

const pool = mysql.createPool({
    host: 'sql5.freesqldatabase.com',
    user: 'sql5750851',
    password: 'EbPmJA6A2d',
    database: 'sql5750851',
});

pool.getConnection()
    .then(connection => {
        pool.releaseConnection(connection);
        console.log('DB is Connected');
    });

export default pool;
