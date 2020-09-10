app.controller( 'loginController',
                ['$scope', '$cookies', '$rootScope', '$http', function($scope, $cookies, $rootScope, $http) {

    //define route and set some defaults in scope
    const route = 'http://localhost:5000/api/user/login';
    $scope.remember = true;
    //get the rootScope.user in childScope
    $scope.rootUser = $rootScope.user;

    //listen to broadcasts on rootScope.user and update childScope user
    $rootScope.$on("user", function(event, options) {
        $scope.rootUser = $rootScope.user;
    });

    //Test
    //fabian.hennemann@baufuchs.de
    //Starten
    //function for backend request
    $scope.submitLoginForm = function() {
        //Backend Request
        $http.post(route, {headers: {'Content-Type': 'application/json;charset=UTF-8'},
                           data: {email: $scope.username, password: $scope.password} })
                .then(function successCallback(response) {
                    //if login data is correct (response_code (rc) = 1)
                    if (response.data.resp.rc == 1) {
                        //when RememberMe is checked, save user login data & cart in cookie
                        if ($scope.remember) {
                            $cookies.putObject('user', {user_id: response.data.resp.user_id,
                                                        email: $scope.username,
                                                        password: $scope.password});
                            $cookies.putObject('cart', $rootScope.cart);
                        } else {
                            $cookies.remove('user');
                            $cookies.remove('cart');
                        }
                        //save user login data in sessions rootScope and broadcast changes
                        $rootScope.user = {user_id: response.data.resp.user_id,
                                           email: $scope.username,
                                           password: $scope.password};
                        $scope.rootUser = $rootScope.user;
                        $rootScope.$broadcast("user", { newValue: $rootScope.user});

                    } else {
                        alert("Benutzername oder Passwort falsch")
                    }

                }, function errorCallback(response) {
                    console.log(response.data);
                    alert('In der API ist ein Fehler aufgetreten.');
                });
    }

    //logout function to remove all cookies & login data
    $scope.logout = function() {
        $cookies.remove('user');
        $cookies.remove('cart');
        $rootScope.user = null;
        $scope.rootUser = null;
        $scope.username = null;
        $scope.password = null;
        $rootScope.$broadcast("user", { newValue: $rootScope.user} );
    }
}])