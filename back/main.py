'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask, mysql-connector-python
'''


# importing modules
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector


# setting session vars
# enableCorss Origin Resource Sharing (CORS) for HTTPRequests

app = Flask(__name__)
CORS(app)
cors = CORS(app, resources={
    r"/*": {
        "origins": "*"
    }
})
app_host = "localhost"
app_port = "5000"
sql_host = "localhost"
sql_user = "root"
sql_key = ""
sql_db = "baufuchs"
sql_buffered = True


sql_con = mysql.connector.connect(
    host="127.0.0.1",
    port="3306",
    user="root",
    database="baufuchs"
)
sql_cur = sql_con.cursor(buffered=True)

'''
sql_cur.execute("SELECT * FROM items")
data = sql_cur.fetchone()
for result in data:
    print(result)
# sql_cur.close()
'''

# routes
# for quick return tests


# routes
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
    return resp


@app.route('/api/item/list', methods=['GET', 'POST'])
def api_item():
    # get filter information
    req = request.get_json().get("data")

    # build sql query using WHERE to match above infos

    sql_cur.execute(("""SELECT * FROM item i
         JOIN item2category i2c ON i2c.item_id = i.item_id
        WHERE i.color LIKE '%s'
          AND i.price BETWEEN %s AND %s
          AND i.value_stock >= %s
          AND i2c.category_id = %s
          LIMIT 0, %s """ % (req.get("color"), req.get("minCost"), req.get("maxCost"), 1, req.get("category"), req.get("limit"))
        ))

    # fetch all returned items
    data=sql_cur.fetchall()

    # loop over each item and build a json object with the general properties
    item_list=[]

    for i in data:
        print(i)
        data_item={
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
    resp=jsonify(item=item_list,
                   score=item_list
                   )
    resp.status_code=200
    return resp


# for recieving and applying score reviews from users
@ app.route('/api/item/score', methods=['POST'])
def api_item_score():
    # get score value etc from request
    req=request.get_json()
    # frontend needs to check for user registration
    # add score to score table
    sql_cur.execute("""INSERT irgendwie * FROM items LIMIT 0, 1
    WHERE """ + req.get("val"))
    # update score data in item table









if __name__ == '__main__':
    app.run(host=str(app_host), port=int(app_port))
