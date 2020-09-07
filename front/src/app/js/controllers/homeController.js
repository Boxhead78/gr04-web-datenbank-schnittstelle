app.controller('homeController', ['$scope', 'itemListFiltered', function($scope, itemListFiltered) {
    itemListFiltered.then(function(items) {
        $scope.items = items.data;

        var y = 1;
        var z = 1;
        for (var x = 0; x<$scope.items.item.length; x++) {

            if (y >= 1) {
                $scope.items.item[x].class = "item-second";
                y--;
            }
            else if (y == 0) {
                $scope.items.item[x].class = "item-first";
                if (z == 2) {
                    y = 2;
                    z = 1;
                } else {
                    z++;
                }
            }
        }
    })
}])