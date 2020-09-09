app.controller('cartController', ['$scope', '$rootScope', function($scope, $rootScope) {
    $scope.cart = $rootScope.cart;

    $scope.removeItem = function(item) {
        var index = $rootScope.cart.indexOf(item);
        $rootScope.cart.splice(index, 1);
    }
}])