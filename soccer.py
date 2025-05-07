import os
from flask import Flask, render_template
from flask_mysqldb import MySQL
from flask import request, redirect, url_for
from flask import request, redirect, url_for, flash

app = Flask(__name__)

#secret stuff 
app.secret_key = os.environ.get("FLASK_SECRET_KEY", "dev_key_for_local_use_only")

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

#player details
@app.route("/player/<player_name>")
def player_detail(player_name):
    cur = mysql.connection.cursor()

    cur.execute("call getPlayerProfile(%s)", (player_name,))
    row = cur.fetchone()

    if not row:
        cur.close()
        return f"No data found for player: {player_name}", 404

    # Get column names from the cursor description
    column_names = [desc[0] for desc in cur.description]
    player_data = dict(zip(column_names, row))

    cur.close()
    return render_template("player_details.html", player=player_data)

#edit player
@app.route("/player/<player_name>/edit", methods=["GET", "POST"])
def edit_player(player_name):
    cur = mysql.connection.cursor()

    if request.method == "POST":
        # Get form data
        new_name = request.form["Player_Name"]
        dob = request.form["Date_of_Birth"]
        nationality = request.form["Nationality"]
        club = request.form["Club"]
        position = request.form["Position"]

        # Update query
        cur.execute("""
            UPDATE Player 
            SET Player_Name = %s,
                Date_of_Birth = %s,
                Nationality_ID = (SELECT Country_ID FROM Country WHERE Country_Name = %s),
                Club_ID = (SELECT Club_ID FROM Club WHERE Club_Name = %s),
                Position_ID = (SELECT Position_ID FROM Position WHERE Position_Name = %s)
            WHERE Player_Name = %s
        """, (new_name, dob, nationality, club, position, player_name))

        mysql.connection.commit()
        cur.close()
        return redirect(url_for("player_detail", player_name=new_name))

    # GET request: load player data for editing
    cur.execute("CALL getPlayerProfile(%s)", (player_name,))
    row = cur.fetchone()
    column_names = [desc[0] for desc in cur.description]
    player_data = dict(zip(column_names, row))
    cur.close()

    return render_template("edit_player.html", player=player_data)

#add a player
@app.route("/player/add", methods=["GET", "POST"])
def add_player():
    cur = mysql.connection.cursor()

    if request.method == "POST":
        name = request.form["Player_Name"]
        dob = request.form["Date_of_Birth"]
        nationality = request.form["Nationality"]
        club = request.form["Club"]
        position = request.form["Position"]

        # Ensure nationality exists or insert it
        cur.execute("SELECT Country_ID FROM Country WHERE Country_Name = %s", (nationality,))
        nat_result = cur.fetchone()
        if not nat_result:
            cur.execute("INSERT INTO Country (Country_Name) VALUES (%s)", (nationality,))
            mysql.connection.commit()
            cur.execute("SELECT LAST_INSERT_ID()")
            nationality_id = cur.fetchone()[0]
        else:
            nationality_id = nat_result[0]

        # Ensure club exists or insert it (assume default league/country for simplicity)
        cur.execute("SELECT Club_ID FROM Club WHERE Club_Name = %s", (club,))
        club_result = cur.fetchone()
        if not club_result:
            # You can prompt user for these in a more advanced version
            default_league = 1
            cur.execute("INSERT INTO Club (Club_Name, League_ID, Country_ID) VALUES (%s, %s, %s)",
                        (club, default_league, nationality_id))
            mysql.connection.commit()
            cur.execute("SELECT LAST_INSERT_ID()")
            club_id = cur.fetchone()[0]
        else:
            club_id = club_result[0]

        # Ensure position exists or insert it
        cur.execute("SELECT Position_ID FROM Position WHERE Position_Name = %s", (position,))
        pos_result = cur.fetchone()
        if not pos_result:
            cur.execute("INSERT INTO Position (Position_Name) VALUES (%s)", (position,))
            mysql.connection.commit()
            cur.execute("SELECT LAST_INSERT_ID()")
            position_id = cur.fetchone()[0]
        else:
            position_id = pos_result[0]

        # Insert player using stored procedure (assumes Position_ID column exists in Player)
        cur.execute("INSERT INTO Player (Player_Name, Date_of_Birth, Nationality_ID, Club_ID, Position_ID) VALUES (%s, %s, %s, %s, %s)",
                    (name, dob, nationality_id, club_id, position_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for("player"))

    # GET: Show empty form
    cur.close()
    return render_template("add_player.html")

#add stats
@app.route("/player/<player_name>/add_stats", methods=["GET", "POST"])
def add_stats(player_name):
    if request.method == "POST":
        season = request.form["season"]
        games_played = request.form["games_played"]
        goals = request.form["goals"]
        assists = request.form["assists"]

        cur = mysql.connection.cursor()

        # Get player ID
        cur.execute("SELECT Player_ID FROM Player WHERE Player_Name = %s", (player_name,))
        player = cur.fetchone()
        if not player:
            cur.close()
            return f"No player found with name {player_name}", 404
        player_id = player[0]

        # Insert the stats
        cur.execute("""
            INSERT INTO Player_Stats (Player_ID, Season, Games_Played, Goals, Assists)
            VALUES (%s, %s, %s, %s, %s)
        """, (player_id, season, games_played, goals, assists))
        mysql.connection.commit()
        cur.close()

        flash("Stats added successfully!")
        return redirect(url_for('player_detail', player_name=player_name))

    return render_template("add_stats.html", player_name=player_name)

#view stats
@app.route("/player/<player_name>/stats")
def view_stats(player_name):
    cur = mysql.connection.cursor()

    # Get the player ID
    cur.execute("SELECT Player_ID FROM Player WHERE Player_Name = %s", (player_name,))
    player_row = cur.fetchone()
    if not player_row:
        cur.close()
        return f"No player found with name: {player_name}", 404

    player_id = player_row[0]

    # Get the player's stats
    cur.execute("""
        SELECT Season, Goals, Assists, Games_Played
        FROM Player_Stats
        WHERE Player_ID = %s
        ORDER BY Season DESC
    """, (player_id,))
    stats = cur.fetchall()
    cur.close()

    return render_template("player_stats.html", player_name=player_name, stats=stats)


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


@app.route("/team/<team_name>")
def team_detail(team_name):
    cur = mysql.connection.cursor()

    cur.execute("SELECT * FROM Club WHERE Club_Name = %s", (team_name,))
    row = cur.fetchone()

    if not row:
        cur.close()
        return f"No data found for team: {team_name}", 404

    # Get column names from the cursor description
    column_names = [desc[0] for desc in cur.description]
    team_data = dict(zip(column_names, row))

    cur.close()
    return render_template("team_details.html", team=team_data)

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

@app.route("/league/<league_name>")
def league_detail(league_name):
    cur = mysql.connection.cursor()

    # Call the stored procedure
    cur.execute("CALL GetClubsByLeague(%s);", (league_name,))
    teams = [row[0] for row in cur.fetchall()]

    cur.close()

    if not teams:
        return f"No data found for league: {league_name}", 404

    return render_template("league_details.html", league_name=league_name, clubs=teams)

#country page
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

