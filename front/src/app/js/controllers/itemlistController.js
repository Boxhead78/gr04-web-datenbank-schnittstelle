app.controller( 'itemlistController',
                ['$scope', '$rootScope', '$cookies', '$http', function($scope, $rootScope, $cookies,  $http) {

    //define route
    const route = 'http://localhost:5000/api/item/filter';

    //Backend Request
    $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                       data: $scope.requestParams //requestParams are defined in parentScope of itemlistController
                      })
        .then(function successCallback(response) {
                $scope.items = response.data;

            }, function errorCallback(response) {
                console.log(response.data);
                alert('In der API ist ein Fehler aufgetreten.');
            });

    //listen to changes on requestParams and send new request when params change
    $scope.$on("requestParams", function(event, options) {
        $scope.requestParams = options.newValue;

        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                           data: $scope.requestParams})
            .then(function successCallback(response) {
                $scope.items = response.data;

            }, function errorCallback(response) {
                console.log(response.data);
                alert('In der API ist ein Fehler aufgetreten.');
            });

        });

    //function to add item to cart/cart-cookie
    $scope.addItem = function(item_id, item_name, count, price) {
        $rootScope.cart.push({id: item_id, name: item_name, count: count, price: price});
            if ($cookies.get('user') ) {
                $cookies.putObject('cart', $rootScope.cart);
            }
    }
}])