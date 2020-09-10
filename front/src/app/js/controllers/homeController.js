app.controller( 'homeController',
                ['$scope', '$rootScope', '$cookies', '$http', function($scope, $rootScope, $cookies, $http) {

    //define route and default variables
    const route = 'http://localhost:5000/api/item/list';
    var limit = { limit: 10 };

    //Backend Request
    $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                       data: limit})
        .then(function successCallback(response) {
            $scope.items = response.data;
            var y = 1;
            var z = 1;
            //determine class for each item
            for (var x = 0; x<$scope.items.item_list.length; x++) {
                if (y >= 1) {
                    $scope.items.item_list[x].class = "item-second";
                    y--;
                }
                else if (y == 0) {
                    $scope.items.item_list[x].class = "item-first";
                    if (z == 2) {
                        y = 2;
                        z = 1;
                    } else {
                        z++;
                    }
                }
            }
        }, function errorCallback(response) {
            console.log(response.data);
            alert('In der API ist ein Fehler aufgetreten.');
        });

    //function to add an item to the cart
    $scope.addItem = function(item_id, item_name, count, price) {
        $rootScope.cart.push({id: item_id, name: item_name, count: count, price});

        if ($cookies.get('user') ) {
            $cookies.putObject('cart', $rootScope.cart);
        }
    }

}])