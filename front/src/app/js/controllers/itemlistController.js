app.controller('itemlistController', ['$scope', '$rootScope', '$cookies', 'itemListFilteredService', function($scope, $rootScope, $cookies, itemListFiltered) {
    itemListFiltered.then(function(items) {
        $scope.items = items.data;
    })

    $scope.addItem = function(item_id, item_name) {
        $rootScope.cart.push({id: item_id, name: item_name});

        if ($cookies.get('user') ) {
            $cookies.putObject('cart', $rootScope.cart);
        }
    }
}])