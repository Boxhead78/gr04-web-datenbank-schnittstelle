app.controller( 'cartController',
                ['$scope', '$rootScope', '$cookies', '$http', function($scope, $rootScope, $cookies, $http) {

    //define route and default variables/containers
    const route = 'http://localhost:5000/api/order/place';
    var requestParams = {email: String,
                         password: String,
                         user_id: Number,
                         order_list: [] };

    //function to remove item from cart
    $scope.removeItem = function(item) {
        var index = $rootScope.cart.indexOf(item);
        $rootScope.cart.splice(index, 1);
        $cookies.putObject('cart', $rootScope.cart);
    }

    //function to pass the order via post request
    $scope.buy = function() {
        //check if user is logged in first
        if ($rootScope.user) {
            requestParams.email = $rootScope.user.email;
            requestParams.password = $rootScope.user.password;
            requestParams.user_id = $rootScope.user.user_id;
            angular.forEach($rootScope.cart, function(value, key) {
                requestParams.order_list.push( {item_id: value.id, count: value.count } );
            })

        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                           data: requestParams
                          })
            .then(function successCallback(response) {
                console.log(response.data);

            }, function errorCallback(response) {
                console.log(response.data);
                alert('In der API ist ein Fehler aufgetreten.');
            });
        } else {
            alert("sie müssen eingeloggt sein, um zu kaufen");
        }
    }

}])