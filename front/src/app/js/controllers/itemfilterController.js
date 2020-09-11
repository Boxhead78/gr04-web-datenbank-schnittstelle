app.controller('itemfilterController',
    ['$scope', '$location', function ($scope, $location) {

        //define default requestParams object
        $scope.requestParams = {
            limit: 20,
            category: null,
            itemName: null,
            color: null,
            minCost: null,
            maxCost: null,
            minStock: null,
            manufactorer: null
        };

        $scope.test = 'Test';

        //setter for each filter criteria
        //every setter broadcasts changes in requestParams
        $scope.setLimit = function (limit) {
            $scope.requestParams.limit = limit;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

        $scope.setCategory = function (categoryid) {
            $scope.requestParams.category = categoryid;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

        $scope.setName = function () {
            $scope.requestParams.itemName = $scope.searchInput;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams })
            $location.path('/item');
        }

        $scope.setColor = function (color) {
                if (color == 'Multi') {
                    color = null;
                }
                $scope.requestParams.color = color;
                $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
                $location.path('/item');
        }

        $scope.setMinCost = function (minCost) {
            $scope.requestParams.minCost = minCost;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

        $scope.setMaxCost = function (maxCost) {
            $scope.requestParams.maxCost = maxCost;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

        $scope.setMinStock = function (minStock) {
            $scope.requestParams.minStock = minStock;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

        $scope.setManufactorer = function(manufactorer) {
            if (manufactorer == 'Alle') {
                manufactorer = null;
            }
            $scope.requestParams.manufactorer = manufactorer;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            $location.path('/item');
        }

    }])