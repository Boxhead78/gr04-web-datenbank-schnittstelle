app.controller('itemlistController',
    [   '$scope', '$rootScope', '$cookies', '$http',
    function($scope, $rootScope, $cookies,  $http) {

        var route = 'http://localhost:5000/api/item/filter';

        //load data
        console.log($scope.requestParams);

        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'}, data: $scope.requestParams})
            .then(function successCallback(response) {
                $scope.items = response.data;

            }, function errorCallback(response) {
                   alert('ERROR');

            });

        $scope.$on("requestParams", function(event, options) {
            $scope.requestParams = options.newValue;

            $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'}, data: $scope.requestParams})
            .then(function successCallback(response) {
                $scope.items = response.data;

            }, function errorCallback(response) {
                   alert('ERROR');

            });

        });

        //add item to cart/cookie
        $scope.addItem = function(item_id, item_name) {
            $rootScope.cart.push({id: item_id, name: item_name});
            if ($cookies.get('user') ) {
                $cookies.putObject('cart', $rootScope.cart);
            }
    }
}])