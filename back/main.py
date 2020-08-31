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
cors =CORS(app, resources= {
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




'''
sql_con = mysql.connector.connect(
    host="sql7.freesqldatabase.com",
    port="3306",
    user="sql7361613",
    password="",
    database="sql7361613",
    #connection_timeout=180
)
sql_cur = sql_con.cursor(buffered=True)


sql_cur.execute("SELECT * FROM items")
data = sql_cur.fetchone()
for result in data:
    print(result)
#sql_cur.close()
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
    sql_cur.execute("SELECT * FROM items LIMIT 0, 1")
    data = sql_cur.fetchone()
    data_item = {
        "id": data[0],
        "name": data[1],
        "description": data[2],
        "numStock": data[3],
        "price": data[4],
        "picture": data[5]
    }
    sql_cur.execute("SELECT * FROM items LIMIT 0, 1") # TODO: make this get scores of the item
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
    request.form.get('term')
    request.form.get('max_cost')
    request.form.get('min_cost')
    request.form.get('category')

# for recieving and applying score reviews from users
@app.route('/api/item/score', methods=['POST'])
def api_item_score():
    #get score value etc from request
    request.form.get('1')
    request.form.get('2')
    request.form.get('3')
    request.form.get('4')
    request.form.get('5')
    #frontend needs to check for user registration
    #add score to score table
    #update score data in item table









if __name__ == '__main__':
    app.run(host=str(app_host), port=int(app_port))
