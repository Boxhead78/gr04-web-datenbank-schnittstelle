app.controller( 'userController',
                ['$scope', '$rootScope', '$cookies', '$routeParams', '$http', function($scope, $rootScope, $cookies, $routeParams, $http) {

    //define route
    const route = 'http://localhost:5000/api/user/details';
    var loggedIn = true;

    //only send request when user is currently logged in
    if ($rootScope.user) {
        loggedIn = true;
        var requestParams = {user_id: $rootScope.user.user_id }; //define

        //Backend Request
        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                           data: requestParams})
            .then(function successCallback(response) {
                $scope.user = response.data.user_details;
                $scope.order_list = response.data.order_list;

            }, function errorCallback(response) {
                console.log(response.data);
                alert('In der API ist ein Fehler aufgetreten.');
            });
    } else {
        loggedIn = false;
    }

    $scope.getTotal = function(orders) {
        var total = 0;
        for(var i = 0; i < orders.length; i++) {
        total += orders[i].price;
    }
    return total;

    }
}])