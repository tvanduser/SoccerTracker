import os
from flask import Flask, render_template
from flask_mysqldb import MySQL

app = Flask(__name__)

#set up database connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = os.environ.get("DB_PASSWORD")  
app.config['MYSQL_DB'] = 'soccerplayerdatabase'

mysql = MySQL(app)
#create a cursor for connection

#-------routing
@app.route("/")
def home_page():
    return render_template("home.html")

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

@app.route("/player/<player_name>")
def player_detail(player_name):
    cur = mysql.connection.cursor()

    cur.execute("SELECT * FROM player WHERE Player_Name = %s", (player_name,))
    row = cur.fetchone()

    if not row:
        cur.close()
        return f"No data found for player: {player_name}", 404

    # Get column names from the cursor description
    column_names = [desc[0] for desc in cur.description]
    player_data = dict(zip(column_names, row))

    cur.close()
    return render_template("player_details.html", player=player_data)

#team page
@app.route("/team")
def team():
    cur = mysql.connection.cursor()
    cur.execute("Select Club_Name from Club")
    teams = [row[0] for row in cur.fetchall()]
    cur.close()

    data = {
            "teams": teams
            }
    return render_template("team.html", data=data)

#league page
@app.route("/league")
def league():
    cur = mysql.connection.cursor()
    cur.execute("Select League_Name from League")
    leagues = [row[0] for row in cur.fetchall()]
    cur.close()

    data = {
            "leagues": leagues
            }
    return render_template("league.html", data=data)


#league page
@app.route("/country")
def country():
    cur = mysql.connection.cursor()
    cur.execute("Select Country_Name from Country")
    countries = [row[0] for row in cur.fetchall()]
    cur.close()

    data = {
            "countries": countries
            }
    return render_template("country.html", data=data)

if __name__ == "__main__":
    app.run(debug=True)

