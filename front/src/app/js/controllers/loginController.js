app.controller('loginController', ['$scope', '$cookies', '$rootScope', '$http', function($scope, $cookies, $rootScope, $http) {
    $scope.remember = true;

    $scope.rootUser = $rootScope.user;

    $scope.submitLoginForm = function() {

        //Backend Request mit den Eingaben
        /*
        $http.post('http://localhost:5000/api/user/login',
            {
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                data: {email: $scope.username, password: $scope.password}
            })
                .then(function successCallback(response) {
                    if ($scope.remember) {
                        $cookies.put('user', response.data.user_id); //user = response user_id
                    } else {
                        $cookies.remove('user');
                    }
                    $rootScope.user = $cookies.get('user') ? $cookies.get('user') : null;
                    $scope.rootUser = $rootScope.user;

                }, function errorCallback(response) {
                    alert(response);
                });
        */
       alert($scope.username + ', ' + $scope.password + ', ' + $scope.remember);
        if ($scope.remember) {
            $cookies.put('user', $scope.username);
        } else {
            $cookies.remove('user');
        }
        $rootScope.user = $scope.username;
        $scope.rootUser = $rootScope.user;



    }

    $scope.removeCookie = function() {
        $cookies.remove('user');
        $rootScope.user = null;
        $scope.rootUser = $rootScope.user;
    }
}])