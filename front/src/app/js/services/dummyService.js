app.factory('dummy', ['$http', function($http) {
    return $http.get('http://localhost:5000/api/hello', {params: {'itemid': "123"}})
        .then(function successCallback(response) {
            return response;
        }, function errorCallback(response) {
            return response;
        });
}])