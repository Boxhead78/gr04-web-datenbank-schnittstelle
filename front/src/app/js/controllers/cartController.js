app.controller( 'cartController',
                ['$scope', '$rootScope', '$cookies', '$http', function($scope, $rootScope, $cookies, $http) {

    //define route and default variables/containers
    const route = 'http://localhost:5000/api/order/place';
    var requestParams = {email: null,
                         password: null,
                         order_list: [] };

    checkIfLoggedIn = function() {
        if ($rootScope.user) {
            return true;
        } else {
            return false;
        }
    }


    //function to remove item from cart
    $scope.removeItem = function(item) {
        var index = $rootScope.cart.indexOf(item);
        $rootScope.cart.splice(index, 1);
        $cookies.putObject('cart', $rootScope.cart);
        console.log($cookies.getObject('cart'));
    }

    //function to pass the order via post request
    $scope.buy = function() {
        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                           data: {test}
                          })
            .then(function successCallback(response) {
                console.log(response.data);

            }, function errorCallback(response) {
                console.log(response.data);
                alert('In der API ist ein Fehler aufgetreten.');
            });
    }

}])