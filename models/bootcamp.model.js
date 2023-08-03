const { pool } = require("../config/db.config");

const getBootcamps = async () => {
    const query = {
        text: "SELECT title, cue, descript FROM bootcamps ORDER BY rut ASC",
    };
    try {
        const bootcamps = await pool.query(query);
        return bootcamps.rows;
    } catch (err) {
        console.log("err.message:", err.message);
        console.log("err.stack:", err.stack);
        return [];
    }
};

const insertBootcamp = async (title, cue, descript) => {
    const query = {
        text: "INSERT INTO bootcamps (title, cue, descript) VALUES ($1, $2, $3) RETURNING *",
        values: [title, cue, descript],
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
    getBootcamps,
    insertBootcamp
};
