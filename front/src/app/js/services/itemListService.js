var dummyRequest = { limit: 10 };

app.factory('itemListService', ['$http', function($http) {
    return $http.post('http://localhost:5000/api/item/list', {headers: {'Content-Type': 'application/json;charset=UTF-8'}, data: dummyRequest})
        .then(function successCallback(response) {
            return response;

        }, function errorCallback(response) {
            return response;

        });
}])