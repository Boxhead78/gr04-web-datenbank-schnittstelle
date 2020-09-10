app.controller('itemfilterController',
    ['$scope', function ($scope) {

        //define default requestParams object
        $scope.requestParams = {
            limit: 20,
            category: Number,
            itemName: String,
            color: String,
            minCost: Number,
            maxCost: Number,
            minStock: Number
        };

        //setter for each filter criteria
        //every setter broadcasts changes in requestParams
        $scope.setLimit = function (limit) {
            $scope.requestParams.limit = limit;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
        }

        $scope.setCategory = function (categoryid) {
            $scope.requestParams.category = categoryid;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
        }

        $scope.setName = function () {
            $scope.requestParams.itemName = $scope.searchInput;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams })
        }

        $scope.setColor = function (color, toggle) {
            if (toggle) {
                $scope.requestParams.color = color;
                $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            } else {
                $scope.requestParams.color = null;
                $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
            }
        }

        $scope.setMinCost = function (minCost) {
            $scope.requestParams.minCost = minCost;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
        }

        $scope.setMaxCost = function (maxCost) {
            $scope.requestParams.maxCost = maxCost;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
        }

        $scope.setMinStock = function (minStock) {
            $scope.requestParams.minStock = minStock;
            $scope.$broadcast("requestParams", { newValue: $scope.requestParams });
        }

    }])