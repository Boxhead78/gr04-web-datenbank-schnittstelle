app.controller('itemdetailController', ['$scope', '$rootScope', '$cookies', '$routeParams', '$http', function($scope, $rootScope, $cookies, $routeParams, $http) {
    $http.post('http://localhost:5000/api/item/details',
            {
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                data: {item_id: $routeParams.id}
            })
        .then(function successCallback(response) {
           $scope.item = response.data.item;

        }, function errorCallback(response) {
            alert(response);
        });

    $scope.addItem = function(item_id, item_name) {
        $rootScope.cart.push({id: item_id, name: item_name});

        if ($cookies.get('user') ) {
            $cookies.putObject('cart', $rootScope.cart);
        }
    }
}])