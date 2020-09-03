var dummyItem = { limit: 10, category: 1, color: "braun", minCost: 1, maxCost: 10, outOfStock_jn: true};

app.factory('itemListFiltered', ['$http', function($http) {
    return $http.post('http://localhost:5000/api/item/list', {headers: {'Content-Type': 'application/json;charset=UTF-8'}, data: dummyItem})
        .then(function successCallback(response) {
            return response;

        }, function errorCallback(response) {
            return response;

        });
}])