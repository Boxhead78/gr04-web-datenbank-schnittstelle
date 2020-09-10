'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask, mysql-connector-python
'''


# importing modules
from flask import Flask, request, jsonify
from flask_cors import CORS
from re import match
import datetime
import argon2
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
argon = argon2.PasswordHasher(time_cost=int(2),
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


# verify authentification of user


def user_verfiy(email, password, sql_cur):
    # get user hash
    sql_cur.execute("""SELECT password FROM user
        WHERE email_address = %s""", (str(email),))
    key = sql_cur.fetchone()
    if key != None:
        # use argon verify
        try:
            argon.verify(str(str(argonprefix) + str(key[0])), str(password))
        # catch exceptions
        except argon2.exceptions.VerifyMismatchError:
            rc = bool(False)
        except:
            rc = bool(False)
            print("Authentification process met an internal error!")
        else:
            rc = bool(True)
        finally:
            return bool(rc)
    else:
        return bool(False)


# add new score to average_rating


def addToAverage(average, size, value):
    return int((size * average + value) / (size + 1))


# Routes

# for getting shop item details to the web-client


@ app.route('/api/item/details', methods=['GET', 'POST'])
def api_item_details():
    req = request.get_json().get("data")
    sql_con, sql_cur = sql_connect()
    sql_cur.execute("""SELECT * FROM item WHERE item_id = %s""",
                    (req.get("item_id"),))
    data = sql_cur.fetchone()
    data_item = {
        "id": data[0],
        "name": data[1],
        "description": data[2],
        "numStock": data[3],
        "price": data[4],
        "picture": data[5],
        "color": data[6],
        "creation_date": data[7],
        "weight": data[8],
        "count": data[9],
        "material": data[10],
        "manufactorer_id": data[11],
        "technical_details": data[12],
        "average_rating": data[13],
        "rating_count": data[14]
    }
    # TODO: make this get scores and each comment of the item
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

# item list returned after filter for items


@ app.route('/api/item/filter', methods=['GET', 'POST'])
def api_item_filter():
    # get filter information
    req = request.get_json().get("data")
    sql_con, sql_cur = sql_connect()
    # searching for name with wildcard in database

    if req.get("itemName") is not None:
        req["itemName"] = "%" + req.get("itemName") + "%"

    # build sql query using WHERE to match above infos
    sql_cur.execute("""SELECT DISTINCT i.item_id, i.name, i.description, i.value_stock, i.price, i.picture, i.creation_date, i.average_rating FROM item i
         JOIN item2category i2c ON i2c.item_id = i.item_id
         JOIN category c ON c.category_id = i2c.category_id
         JOIN manufactorer m ON m.manufactorer_id = i.manufactorer_id
        WHERE (%s IS NULL OR i.name LIKE %s) 
          AND (%s IS NULL OR i.color LIKE %s)
          AND (%s IS NULL OR i.price BETWEEN %s AND %s)
          AND (%s IS NULL OR i.value_stock >= %s)
          AND (%s IS NULL OR m.name = %s )
          AND ( (%s IS NULL OR i2c.category_id = %s)
                OR (%s IS NULL OR c.category_parent_id = %s))
          LIMIT 0, %s""", (req.get("itemName"), req.get("itemName"), req.get("color"), req.get("color"), req.get("minCost"), req.get("minCost"),
                           req.get("maxCost"), req.get("minStock"), req.get("minStock"), req.get("manufactorer"), req.get("manufactorer"), req.get("category"), req.get("category"), req.get("category"), req.get("category"), req.get("limit"),)
                    )
    # fetch all returned items
    data = sql_cur.fetchall()

    # loop over each item and build a json object with the general properties
    item_list = []
    for i in data:
        print("item_id: ", i[0])
        sql_cur.execute(
            """SELECT sum(od.count) FROM item i JOIN order_details od ON od.item_id = i.item_id WHERE i.item_id = %s GROUP BY i.item_id""", (i[0], ))
        result = sql_cur.fetchone()
        if result is not None:
            number_of_orders = int(result[0])
        else:
            number_of_orders = 0
        print(number_of_orders)
        data_item = {
            "id": i[0],
            "name": i[1],
            "description": i[2],
            "numStock": i[3],
            "price": i[4],
            "picture": i[5],
            "creation_date": i[6],
            "average_rating": i[7],
            "number_of_orders": number_of_orders
        }
        item_list.append(data_item)
    print(item_list)
    # return the json object
    resp = jsonify(item=item_list
                   )
    resp.status_code = 200
    sql_cur.close()
    sql_con.close()
    return resp


# for recieving and applying score reviews from users
# json input: item_id, user_id, new_rating_value, email, password

@ app.route('/api/item/score', methods=['POST', 'GET'])
def api_item_score():
    new_average_rating = 0
    # get score value etc from request
    req = request.get_json().get("data")
    resp = {"rc": int(0),
            "average_rating": new_average_rating}
    # frontend needs to check for user registration
    sql_con, sql_cur = sql_connect()
    if user_verfiy(req.get("email"), req.get("password"), sql_cur):
        # add score to score table
        sql_cur.execute("""INSERT INTO rating (rating_value)
            VALUES (%s)""", (req.get("new_rating_value"),))
        sql_con.commit()

        # fetching new rating id
        rating_id = sql_cur.lastrowid

        # connecing new rating with item in database
        sql_cur.execute("""INSERT INTO rating2item (rating_id, item_id, user_id)
            VALUES (%s, %s, %s)""", (rating_id, req.get("item_id"), req.get("user_id"),))
        sql_con.commit()

        # fetching required data for calculating new_average_rating
        sql_cur.execute(
            """SELECT average_rating, rating_count FROM item WHERE item_id = %s """, (req.get(
                "item_id"),))
        result = sql_cur.fetchone()

        # calculate new average_rating for item
        new_average_rating = addToAverage(
            result[1], result[0], req.get("new_rating_value"))

        # update score data in item table
        sql_cur.execute("""UPDATE item SET average_rating = %s WHERE item_id = %s """, (
            new_average_rating, req.get("item_id"),))
    else:
        resp["rc"] = int(1)
    sql_con.commit()
    sql_cur.close()
    sql_con.close()
    return jsonify(resp=resp)


@ app.route('/api/item/list', methods=['GET', 'POST'])
def api_item_list():
    req = request.get_json().get("data")
    sql_con, sql_cur = sql_connect()
    sql_cur.execute(
        """SELECT DISTINCT i.item_id, i.name, i.description, i.value_stock, i.price, i.picture, i.creation_date FROM item i LIMIT 0, %s""", (req.get("limit"),))
    data = sql_cur.fetchall()
    item_list = []
    for i in data:
        data_item = {
            "id": i[0],
            "name": i[1],
            "description": i[2],
            "numStock": i[3],
            "price": i[4],
            "picture": i[5],
            "creation_date": i[6],
        }
        item_list.append(data_item)
    sql_cur.close()
    sql_con.close()
    resp = jsonify(item_list=item_list
                   )
    resp.status_code = 200
    return resp


@ app.route('/api/user/login', methods=['POST'])
def api_login():
    # get request json and login data
    req = request.get_json().get("data")
    resp = {"rc": int(1), "user_id": int(0)}
    # compare user data from db
    sql_con, sql_cur = sql_connect()
    if user_verfiy(req.get("email"), req.get("password"), sql_cur):
        sql_cur.execute(
            """SELECT user_id FROM user WHERE email_address = %s""", (str(req.get("email")),))
        # return user id and success code
        resp["user_id"] = int(sql_cur.fetchone()[0])
        resp["rc"] = int(0)
        resp.update()
        # check for argon rehash suggestion
        sql_cur.execute(
            """SELECT password FROM user WHERE email_address = %s""", (str(req.get("email")),))
        key = sql_cur.fetchone()[0]
        if argon.check_needs_rehash(str(argonprefix + str(key))):
            key = str(argon.hash(req.get("password")).split("=")[-1])
            sql_cur.execute("""UPDATE user SET password = %s WHERE user_id = %s """, (
                str(key), resp.get("user_id"),))
            sql_cur.commit()
    sql_cur.close()
    sql_con.close()
    return jsonify(resp=resp)


@ app.route('/api/user/register', methods=['POST'])
def api_register():
    # get request data
    req = request.get_json().get("data")
    resp = {"rc": int(1),
            "id": int(0)}
    # catch exceptions in entered data using regex
    if (match(r"^[a-z]([w-]*[a-z]|[w._]*[a-z]{2,}|[a-z])*@[a-z]([w-]*[a-z]|[w.]*[a-z]{2,}|[a-z]){2,}?.[a-z]{2,}$", str(req.get("email")))
        and match(r"^[a-zA-Z]*$", str(req.get("first_name")))
        and match(r"^[a-zA-Z]*$", str(req.get("surname")))
        and match(r"^[\d]{2}.[\d]{2}.[\d]{4}$", str(req.get("birthday")))
        and match(r"^[\w ßöäüÖÄÜ]+$", str(req.get("street")))
        and match(r"^[\w ]+$", str(req.get("house_number")))
        and match(r"^[\w ßöäüÖÄÜ]+$", str(req.get("city")))
            and match(r"^[\w ßöäüÖÄÜ]+$", str(req.get("country")))):
        resp["rc"] = int(2)
        return jsonify(resp=resp)
    # check for duplicate users
    sql_con, sql_cur = sql_connect()
    sql_cur.execute("""SELECT * FROM user
        WHERE email_address = %s""", (req.get("email"),))
    res = sql_cur.fetchone()
    if res != None:
        sql_cur.close()
        sql_con.close()
        return jsonify(resp=resp)
    else:
        # compile data
        req["password"] = str(argon.hash(req.get("password")).split("=")[-1])
        req_tmp = str(req.get("birthday").split("."))
        req["birthday"] = str(req_tmp[2] + "-" + req_tmp[1] + "-" + req_tmp[0])
        req.update()
        # commit new data to sql db
        # check for country and country id in country table
        sql_cur.execute("""SELECT country_id FROM country
            WHERE country_name = %s""", (str(req.get("country_name")),))
        country_id = sql_cur.fetchone()
        if country_id == None:
            sql_cur.execute("""INSERT INTO country (country_name) VALUES (%s)""", (str(req.get("country_name")),))
            sql_cur.commit()
            country_id = sql_cur.lastrowid
        else:
            country_id = country_id[0]
        # !DEBUG: hardcoded country - remove to allow for all countries
        country_id = int(1)
        # check for duplicate addresses
        sql_cur.execute("""SELECT address_id FROM address
            WHERE street = %s
            AND house_number = %s
            AND post_code = %s
            AND city = %s
            AND country_id = %s""", (
            str(req.get("street")),
            str(req.get("house_number")),
            str(req.get("post_code")),
            str(req.get("city")),
            str(country_id),))
        address_id = sql_cur.fetchone()
        if address_id == None
            sql_cur.execute("""INSERT INTO address (street, house_number, post_code, city, country_id)
                VALUES (%s, %s, %s, %s, %s)""", (
                    str(req.get("street")),
                    str(req.get("house_number")),
                    str(req.get("post_code")),
                    str(req.get("city")),
                    str(country_id),))
            sql_cur.commit()
            address_id = sql_cur.lastrowid
        else:
            address_id = address_id[0]
        # get gender id
        # !DEBUG: can be commented if gender id is what json contains and not a gender name
        sql_cur.execute("""SELECT gender_id FROM gender WHERE name = %s""", (str(req.get("gender")),))
        gender_id = sql_cur.fetchone()
        if gender_id == None:
            sql_cur.execute("""INSERT INTO gender (name) VALUES (%s)""", (str(req.get("gender")),))
            sql_cur.commit()
            gender_id = sql_cur.lastrowid
        else:
            gender_id = gender_id[0]
        # get payment id
        # !DEBUG: same this here as above
        sql_cur.execute("""SELECT payment_id FROM payment WHERE name = %s""", (str(req.get("payment")),))
        payment_id = sql_cur.fetchone()
        if payment_id == None:
            sql_cur.execute("""INSERT INTO payment (name) VALUES (%s)""", (str(req.get("payment")),))
            sql_cur.commit()
            payment_id = sql_cur.lastrowid
        else:
            payment_id = payment_id[0]
        # add other values for query
        # !DEBUG: replace id vars with req-gets if above debug cases turn out true
        sql_cur.execute("""INSERT INTO user (first_name, surname, email_address, gender_id, birthday, payment_id, address_id, password)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""", (
            str(req.get("first_name")),
            str(req.get("surname")),
            str(req.get("email")),
            str(gender_id),
            str(req.get("birthday")),
            str(payment_id),
            str(address_id)
            str(req.get("password")),))
        sql_con.commit()
        resp["rc"] = int(0)
        resp["id"] = int(sql_cur.lastrowid)
        resp.update()
        sql_cur.close()
        sql_con.close()
        # return success code
        return jsonify(resp=resp)

# json input: email, password of user, item_ids, counts,


@ app.route('/api/order/place', methods=['POST'])
def api_order_place():
    # get request data
    req = request.get_json().get("data")
    resp = {"rc": int(0)}
    sql_con, sql_cur = sql_connect()
    # check authority of user
    if user_verfiy(req.get("email"), req.get("password"), sql_cur):

        # commit order to sql db
        now = datetime.datetime.now()
        formatted_date = now.strftime('%Y-%m-%d %H:%M:%S')
        sql_cur.execute("""INSERT INTO baufuchs.`order` (user_id, booking_date, creation_date) VALUES (%s, %s, %s)""", (req.get(
            "user_id"), formatted_date, formatted_date,))
        sql_con.commit()
        order_id = sql_cur.lastrowid
        # compile order details
        for i in req.get("order_list"):
            sql_cur.execute("""INSERT INTO order_details (order_id, item_id, count) VALUES (%s, %s, %s)""",
                            (order_id, i["item_id"], i["count"],))
            # reduce value_stock of item by number of bought items
            sql_cur.execute(
                """UPDATE item i SET i.value_stock =  i.value_stock - %s WHERE i.item_id = %s""", (i["count"], i["item_id"],))
        sql_con.commit()
    else:
        resp["rc"] = int(1)
    sql_cur.close()
    sql_con.close()
    # return success code
    return jsonify(resp=resp)


@ app.route('/api/user/details', methods=['POST', 'GET'])
def api_user_details():
    # get request data
    req = request.get_json().get("data")
    sql_con, sql_cur = sql_connect()
    # collecting all details of a user
    sql_cur.execute(
        """SELECT u.first_name, u.surname, u.birthday, u.email_address, a.street, a.house_number, a.post_code, a.city, c.country_name, l.name AS language,
         p.name AS payment FROM user u JOIN address a ON a.address_id = u.address_id
         JOIN language l ON l.language_id = u.language_id JOIN payment p ON p.payment_id = u.payment_id JOIN country c .country_id = a.country_id
         WHERE u.user_id = %s""", (req.get("user_id"),))
    data = sql_cur.fetchone()
    data_item = {
        "first_name": data[0],
        "surname": data[1],
        "birthday": data[2],
        "email_address": data[3],
        "street": data[4],
        "house_number": data[5],
        "post_code": data[6],
        "city": data[7],
        "country": data[8],
        "language": data[9],
        "payment": data[10]
    }

    sql_cur.execute("""SELECT o.booking_date, i.name AS item_name, i.price, od.count FROM baufuchs.`order` o JOIN order_details od ON od.order_id = o.order_id JOIN item i ON i.item_id = od.item_id WHERE o.user_id = %s""", (req.get("user_id"),))
    data = sql_cur.fetchall()
    # formatting result
    order_list = []
    for i in data:
        order = []
        if not any(d['booking_date'] == i[0] for d in order_list):
            for j in data:
                if (i[0] == j[0]):
                    item = {
                        "item_name": j[1],
                        "price": j[2],
                        "count": j[3]
                    }
                    order.append(item)
            order = {
                "booking_date": i[0],
                "order": order
            }
            order_list.append(order)

    return jsonify(user_details=data_item, order_list=order_list)


if __name__ == '__main__':
    app.run(host=str(app_host), port=int(app_port))
