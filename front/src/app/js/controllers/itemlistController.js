app.controller('itemlistController', ['$scope', 'itemListFilteredService', function($scope, itemListFiltered) {
    itemListFiltered.then(function(data) {
        $scope.items = data.data;
    })
}])