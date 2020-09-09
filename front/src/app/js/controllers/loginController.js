app.controller('loginController', ['$scope', '$cookies', '$rootScope', '$http', function($scope, $cookies, $rootScope, $http) {
    $scope.remember = true;

    $scope.rootUser = $rootScope.user;

    $scope.submitLoginForm = function() {

        //BackendTest
        //fabian.hennemann@baufuchs.de
        //Starten

        //Backend Request mit den Eingaben

        $http.post('http://localhost:5000/api/user/login',
            {
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                data: {email: $scope.username, password: $scope.password}
            })
                .then(function successCallback(response) {
                    if (response.data.resp.rc == 1) {
                        if ($scope.remember) {
                            $cookies.put('user', response.data.resp.user_id);
                            $cookies.putObject('cart', $rootScope.cart);
                        } else {
                            $cookies.remove('user');
                            $cookies.remove('cart');
                        }
                        $rootScope.user = response.data.resp.user_id;
                        $scope.rootUser = $rootScope.user;
                    }
                }, function errorCallback(response) {
                    alert("ACHTUNG ACHTUNG ERROR");
                });

                /*
       alert($scope.username + ', ' + $scope.password + ', ' + $scope.remember);
        if ($scope.remember) {
            $cookies.put('user', $scope.username);
        } else {
            $cookies.remove('user');
        }
        $rootScope.user = $scope.username;
        $scope.rootUser = $rootScope.user;*/
    }

    $scope.removeCookie = function() {
        $cookies.remove('user');
        $cookies.remove('cart');
        $rootScope.user = null;
        $scope.rootUser = $rootScope.user;
    }
}])