const { pool } = require("../config/db.config");

const findAll = async () => {
    const query = {
        text: "SELECT firstname, lastname, email FROM users ORDER BY rut ASC",
    };
    try {
        const students = await pool.query(query);
        return students.rows;
    } catch (err) {
        console.log("err.message:", err.message);
        console.log("err.stack:", err.stack);
        return [];
    }
};

const createUser = async (firstname, lastname, email) => {
    const query = {
        text: "INSERT INTO users (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING *",
        values: [firstname, lastname, email],
    };
    try {
        const res = await pool.query(query);
        //console.log(`Se ha agregado el estudiante ${firstname}`);
        //console.log('res.rows[0]:', res.rows[0]);
        return res.rows[0];
    } catch (error) {
        console.log("err.message:", err.message);
        console.log("err.stack:", err.stack);
        return [];
    }
};

module.exports = {
    findAll,
    createUser,
};

