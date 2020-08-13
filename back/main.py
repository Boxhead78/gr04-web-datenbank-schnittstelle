'''
Baufuchs Online-Shop backend
Python 3.x
Modules: Flask, 
'''

## importing modules
from flask import Flask

## setting session vars
app = Flask(__name__)

## routes
# for quick return tests
@app.route('/api/hello')
def api_hello():
    return 'Hello, World!'

# for getting shop item details to the web-client
@app.route('/api/item/details')
@app.route('/api/item/list')
def api_item():
    data = {}
    return data








if __name__ == '__main__':
    app.run()