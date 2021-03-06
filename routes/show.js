const express = require('express');
const router = express.Router();
const mysql = require('mysql');

const con = mysql.createConnection({
	host: process.env.DB_HOST,
	user: process.env.DB_USERNAME,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME
});

router.get('/', (req, res) => {
	con.query('SELECT show_name, DATE_FORMAT(show_time, "%H:%i %M %D %a") as show_time, show_location FROM shows ORDER BY show_time', (error, results, fields) => {
		if (error) throw error;
		console.log(results);
		return res.status(200).render('shows', { shows: results, clickHandler: 'func1()' });
	});
});

router.get('/popular', (req, res) => {
	con.query(
		'SELECT Show_Name, COUNT(Guest_ID) FROM Watches GROUP BY Show_Name HAVING COUNT(Guest_ID) >= 2 ORDER BY COUNT(Guest_ID) DESC',
		(error, results, fields) => {
			if (error) throw error;
			console.log(results);
			return res.status(200).render('shows_popular', { shows: results, clickHandler: 'func1()' });
		}
	);
});

module.exports = router;
