'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask, mysql-connector-python
'''


# importing modules
from flask import Flask, request, jsonify
from flask_cors import CORS
from argon2 import PasswordHasher
import sys
import os
import mysql.connector


# setting session vars
# enableCorss Origin Resource Sharing (CORS) for HTTPRequests
app_host = "localhost"
app_port = "5000"
sql_host = "127.0.0.1"
sql_port = "3306"
sql_user = "root"
sql_db = "baufuchs"
sql_buffered = True

app = Flask(__name__)
CORS(app)
cors = CORS(app, resources={
    r"/*": {
        "origins": "*"
    }
})
argon = PasswordHasher(time_cost=int(2),
    memory_cost=int(51200),
    parallelism=int(2),
    hash_len=int(16),
    salt_len=int(8),
    encoding=str('utf-8'))
argonprefix = str("$argon2id$v=19$m=51200,t=2,p=")

# Argument parsing
# option to disable output to stdout (--silent)
if str("--silent") in sys.argv:
    sys.stdout = open(os.devnull, 'w')

# Methods
# Creates a new connection to a database and a cursor and returns both as a tuple
def sql_connect():
    sql_newcon = mysql.connector.connect(
        host=str(sql_host),
        port=str(sql_port),
        user=str(sql_user),
        database=str(sql_db)
    )
    sql_newcur = sql_newcon.cursor(buffered=True)
    print("New connector to " + str(sql_host))
    return sql_newcon, sql_newcur


def addToAverage(average, size, value):
    return int((size * average + value) / (size + 1))


def subtractFromAverage(average, size, value):
    return int((size * average - value) / (size - 1))

# Routes
# for quick return tests


@app.route('/api/hello', methods=['GET'])
def api_hello():
    data = {
        "username": "Test",
        "password": "Testkey"
    }
    resp = jsonify(item=data,
                   scores=data)
    resp.status_code = 200
    return resp

# for getting shop item details to the web-client


@app.route('/api/item/details', methods=['GET', 'POST'])
def api_item_details():
    sql_con, sql_cur = sql_connect()
    sql_cur.execute("SELECT * FROM item LIMIT 0, 1")
    data = sql_cur.fetchone()
    data_item = {
        "id": data[0],
        "name": data[1],
        "description": data[2],
        "numStock": data[3],
        "price": data[4],
        "picture": data[5]
    }
    # TODO: make this get scores of the item
    sql_cur.execute("SELECT * FROM item LIMIT 0, 1")
    data = sql_cur.fetchone()
    data_scores = {
        "id": data[0]
    }
    resp = jsonify(item=data_item,
                   score=data_scores
                   )
    resp.status_code = 200
    sql_cur.close()
    sql_con.close()
    return resp


@app.route('/api/item/list', methods=['GET', 'POST'])
def api_item():
    # get filter information
    req = request.get_json().get("data")
    print(req)
    sql_con, sql_cur = sql_connect()
    # build sql query using WHERE to match above infos
    sql_cur.execute("""SELECT * FROM item i
         JOIN item2category i2c ON i2c.item_id = i.item_id
        WHERE (%s IS NULL OR i.color LIKE %s)
          AND (%s IS NULL OR i.price BETWEEN %s AND %s)
          AND (%s IS NULL OR i.value_stock >= %s) 
          LIMIT 0, %s""", (req.get("color"), req.get("color"), req.get("minCost"), req.get("minCost"),
                           req.get("maxCost"), req.get("minStock"), req.get("minStock"), req.get("limit"),)
                    )
    # fetch all returned items
    data = sql_cur.fetchall()
    # loop over each item and build a json object with the general properties
    item_list = []
    for i in data:
        print(i)
        data_item = {
            "id": i[0],
            "name": i[1],
            "description": i[2],
            "numStock": i[3],
            "price": i[4],
            "picture": i[5],
            "color": i[6],
            "creation_date": i[7],
            "currency_id": i[8],
            "weight": i[9],
            "count": i[10],
            "material": i[11],
            "manufactorer_id": i[12],
            "technical_details": i[13]
        }
        item_list.append(data_item)
    # return the json object
    resp = jsonify(item=item_list,
                   score=item_list
                   )
    resp.status_code = 200
    sql_cur.close()
    sql_con.close()
    return resp


# for recieving and applying score reviews from users
@ app.route('/api/item/score', methods=['POST'])
def api_item_score():
    # get score value etc from request
    req = request.get_json().get("data")
    # frontend needs to check for user registration
    # add score to score table
    sql_con, sql_cur = sql_connect()

    sql_cur.execute("""INSERT INTO rating (rating_value)
        VALUES (%s);""", (req.get("rating_value"),))
    sql_con.commit()

    # fetching new rating id
    sql_cur.execute("""SELECT @@IDENTITY AS 'Identity'""")
    rating_id = int(sql_cur.fetchone())

    # connecing new rating with item in database
    sql_cur.execute("""INSERT INTO rating2item (rating_id, item_id, user_id)
        VALUES (%s, %s, %s)""", (rating_id, req.get("user_id"), req.get("item_id"),))
    sql_con.commit()

    # calculate new average_rating for item
    new_average_rating = addToAverage(req.get(""),)

    # update score data in item table
    sql_cur.execute("""UPDATE item SET rating_average = %s WHERE item_id = %s """, (
        rating_average, req.get("item_id"),))
    sql_con.commit()
    sql_cur.close()
    sql_con.close()
    return new_average_rating

@app.route('/api/user/login', methods=['POST'])
def api_login():
    # get request json and login data
    req = request.get_json().get("data")
    # compare user data from db
    # argon rehash
    # return user id and success code
    # front-end saves rest of the data entered in a cookie
    pass

@app.route('/api/user/register', methods=['POST'])
def api_register():
    # get request data
    req = request.get_json().get("data")
    # TODO handle exceptions in entered data
    sql_con, sql_cur = sql_connect()
    sql_cur.execute("""SELECT * FROM user
        WHERE email = %s""", (req.get("email"),) )
    res = sql_cur.fetchone()
    if res != None:
        sql_cur.close()
        sql_con.close()
        return # TODO return fail code because user/email already in use
    # TODO confirm registration via oauth/mail
    # compile data
    req["password"] = str(argon.hash(req.get("password")).split("=")[-1])
    # commit new data to sql db
    sql_cur.execute("""INSERT INTO user (rating_id, item_id, user_id)
        VALUES (%s, %s, %s)""", (rating_id, req.get("user_id"), req.get("item_id"),))
    sql_con.commit()
    sql_cur.close()
    sql_con.close()
    # return success code
    return

@api.route('/api/order/place', methods=['POST'])
def api_order_place():
    # get request data
    # check authority of user
    # compile order details
    # commit order to sql db
    # return success code
    pass 


if __name__ == '__main__':
    app.run(host=str(app_host), port=int(app_port))
