app.controller('itemdetailController', ['$scope', '$routeParams', '$http', function($scope,  $routeParams, $http) {
    $http.post('http://localhost:5000/api/item/details',
            {
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                data: {item_id: $routeParams.id}
            })
        .then(function successCallback(response) {
           $scope.item = response.data;

        }, function errorCallback(response) {
            alert(response);
        });
}])