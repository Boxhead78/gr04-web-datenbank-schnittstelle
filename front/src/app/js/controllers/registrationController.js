app.controller( 'registrationController',
                ['$scope', '$cookies', '$rootScope', '$http', function($scope, $cookies, $rootScope, $http) {

    //define route and set some defaults in scope
    const route = 'http://localhost:5000/api/user/register';
    $scope.success = false;
    $scope.rootUser = $rootScope.user;

    //listen to broadcasts on rootScope.user and update childScope user
    $rootScope.$on("user", function(event, options) {
        $scope.rootUser = $rootScope.user;
    });

    //empty registrationForm
    $scope.request = { first_name: null,
                       surname: null,
                       email: null,
                       gender: 1,
                       birthday: null,
                       payment_method: null,
                       password: null,
                       street: null,
                       house_number: null,
                       post_code: null,
                       city: null,
                       country_id: 1 };


    $scope.submitRegistrationForm = function() {
        console.log($scope.request);

        //TODO space for further validation of form

        //Backend Request
        $http.post(route, { headers: {'Content-Type': 'application/json;charset=UTF-8'},
                            data: $scope.request})
                .then(function successCallback(response) {
                    if (response.data.resp.rc == 0) {
                        alert('SUCCESS'); //TODO
                        $scope.success = true;

                    }
                    }, function errorCallback(response) {
                        console.log(response.data);
                        alert('In der API ist ein Fehler aufgetreten.');
                    });
        }


        $scope.logout = function() {
            $cookies.remove('user');
            $cookies.remove('cart');
            $rootScope.user = null;
            $scope.rootUser = null;
            $rootScope.$broadcast("user", { newValue: $rootScope.user});
        }
}])