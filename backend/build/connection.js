"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const promise_mysql_1 = __importDefault(require("promise-mysql"));
const pool = promise_mysql_1.default.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "Root123.",
    database: "orderit",
});
pool.getConnection().then((connection) => {
    pool.releaseConnection(connection);
    console.log("DB is Connected");
});
exports.default = pool;
