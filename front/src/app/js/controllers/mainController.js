app.controller('mainController', ['$scope', 'itemListFiltered', function($scope, itemListFiltered) {
    itemListFiltered.then(function(data) {
        $scope.items = data.data;
    })
}])