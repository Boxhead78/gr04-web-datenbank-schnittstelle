# API / backend information

### Requirements:
Flask python module: pip install flask
mysql.connector python modul: pip install mysql.connector
Argon2 password hasher: pip install argon2-cffi




### API endpoints:
The API generally sends and accepts only json content types

#### /api/hello [GET]
```
>>> null
<<< {"username": <str>, "password": <str>}
```
> for having a test route that responds with two json key-value pairs

#### /api/item/details [GET]
```
>>> {"id": <int>}
<<< {"data": {"name": <str>, "desc": <str>, "numStock": <int>, "price": <float>, "pic": <int>, "scAvg": <float>, "scNum": <int>},
     "scores": {"1": <int>, "2": <int>, "3": <int>, "4" <int>, "5" <int>} }
```
> for requesting all data about a single item in the database
and the sum of scores for it

#### /api/item/list [GET]
```
>>> {"term": <str>, "costMin": <float>, "costMax": <float>, "cat": <int>}
<<< { "items": {"": } ...{n} }
```
> for adding or changing a score from a user,
setting "val" to "0" will trigger its removal

#### /api/item/score [POST]
```
>>> {"userID": <int>, "userAuth": <str>, "val": <int>, "item": <int>}
<<< {"stat": <int>, "msg": <str>}
```
> for adding or changing a score from a user,
setting "val" to "0" will trigger its removal