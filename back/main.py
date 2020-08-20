'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask 
'''

# importing modules
from flask import Flask, request, jsonify
import mysql.connector


# setting session vars
app = Flask(__name__)


sql_con = mysql.connector.connect(
    host="127.0.0.1",
    port="1337",
    user="root",
    database="baufuchsos"
)
sql_cur = sql_con.cursor(buffered=True)

'''
sql_cur.execute("SELECT * FROM items")
data = sql_cur.fetchone()
for result in data:
    print(result)
sql_cur.close()
'''


# routes
# for quick return tests


@app.route('/api/hello', methods=['GET'])
def api_hello():
    data = {
        "username": "Test",
        "password": "Testkey"
    }
    resp = jsonify(username="Test",
                   password="Testkey")
    resp.status_code = 200
    return resp

# for getting shop item details to the web-client


@app.route('/api/item/details', methods=['GET', 'POST'])
def api_item_details():
    sql_cur.execute("SELECT * FROM items LIMIT 0, 1")
    data = sql_cur.fetchone()
    resp = jsonify(id=data[0],
                   name=data[1],
                   description=data[2],
                   numStock=data[3],
                   price=data[4],
                   picture=data[5]
                   )
    resp.status_code = 200
    return resp


@app.route('/api/item/list', methods=['GET', 'POST'])
def api_item():
    data = sql_get()
    return data

# for sending and applying score reviews from users


@app.route('/api/item/score', methods=['GET', 'POST'])
def api_item_score():
    data = request


if __name__ == '__main__':
    app.run()
