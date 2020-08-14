'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask, 
'''

## importing modules
from flask import Flask, request, jsonify
import mysql.connector



## setting session vars
app = Flask(__name__)

'''
sql_con = mysql.connector.connect(
    host="localhost",
    user="yourusername",
    password="yourpassword"
)
sql_cur = sql_con.cursor()
'''





## routes
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
    data = sql_get()
    return data
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