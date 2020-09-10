app.controller( 'itemdetailController',
                ['$scope', '$rootScope', '$cookies', '$routeParams', '$http', function($scope, $rootScope, $cookies, $routeParams, $http) {

    //define route
    const route = 'http://localhost:5000/api/item/details';
    var requestParams = {item_id: $routeParams.id};

    //Backend Request
    $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                       data: requestParams})
        .then(function successCallback(response) {
           $scope.item = response.data.item;

        }, function errorCallback(response) {
            console.log(response.data);
            alert('In der API ist ein Fehler aufgetreten.');
        });

    //add an item to the cart
    $scope.addItem = function(item_id, item_name, count, price) {
        $rootScope.cart.push({id: item_id, name: item_name, count: count, price: price});

        //if user is saved in cookies also save cart in cookies
        if ($cookies.get('user') ) {
            $cookies.putObject('cart', $rootScope.cart);
        }
    }

}])