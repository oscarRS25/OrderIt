import mysql from 'promise-mysql';

const pool = mysql.createPool({
    host: 'sql.freesqldatabase.com',
    user: 'sql3737832',
    password: '26RYgsSb1h',
    database: 'sql3737832',
});

pool.getConnection()
    .then(connection => {
        pool.releaseConnection(connection);
        console.log('DB is Connected');
    });

export default pool;
