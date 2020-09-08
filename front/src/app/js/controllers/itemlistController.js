app.controller('itemlistController', ['$scope', 'itemListFilteredService', function($scope, itemListFiltered) {
    itemListFiltered.then(function(items) {
        $scope.items = items.data;
    })
}])