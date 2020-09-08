var dummyItem = { limit: 10, category: null, color: null, minCost: null, maxCost: null, minStock: null};

app.factory('itemListFilteredService', ['$http', function($http) {
    return $http.post('http://localhost:5000/api/item/filter', {headers: {'Content-Type': 'application/json;charset=UTF-8'}, data: dummyItem})
        .then(function successCallback(response) {
            return response;

        }, function errorCallback(response) {
            return response;

        });
}])