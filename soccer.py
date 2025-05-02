from flask import Flask, render_template
from flask_mysqldb import MySQL

app = Flask(__name__)

#set up database connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Lps102104'
app.config['MYSQL_DB'] = 'soccerplayerdatabase'

mysql = MySQL(app)
#create a cursor for connection

#-------routing
@app.route("/")
def home_page():
    return render_template("index.html")

#player
@app.route("/player")
def player():

    cur = mysql.connection.cursor()
    cur.execute("Select Player_Name from player")
    players = [row[0] for row in cur.fetchall()]
    cur.close()

    data = {
            "players": players
            }
    return render_template("player.html", data=data)

@app.route("/team")
def team():
    data = {
            "teams": ["Team A", "Team B", "Team C"]
            }
    return render_template("team.html", data=data)

@app.route("/league")
def league():
    data = {
            "leagues": ["League 1", "League 2", "League 3"]
            }
    return render_template("league.html", data=data)

if __name__ == "__main__":
    app.run(debug=True)

