const express = require('express');
const router = express.Router();
const mysql = require('mysql');

const con = mysql.createConnection({
	host: process.env.DB_HOST,
	user: process.env.DB_USERNAME,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME
});

router.post('/clean', (req, res) => {
	const { cleaningStaff, cageToClean } = req.body;
	const q = `REPLACE INTO Cleans (Zookeeper_ID, Cage_ID) VALUES (${cleaningStaff}, ${cageToClean})`;
	con.query(q, (error, result) => {
		if (error) throw error;
		console.log(result);
		return res.status(200).redirect('/');
	});
});

router.get('/dirty', (req, res) => {
	const q =
		`SELECT DISTINCT c.Location, DATE_FORMAT(cl.Date_Time, "%H:%i %M %D %a") AS Date_Time, c.Size FROM cage c, cleans cl` +
		` WHERE c.ID=cl.Cage_ID and c.ID NOT IN (SELECT cl2.Cage_ID FROM Cleans cl2 WHERE cl2.Date_Time > ADDDATE(NOW(), INTERVAL -1 DAY))`;
	con.query(q, (error, results, fields) => {
		if (error) throw error;
		console.log(results);
		res.render('dirtyCage', { cages: results });
	});
});

module.exports = router;
