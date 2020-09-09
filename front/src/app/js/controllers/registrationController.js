app.controller('registrationController', ['$scope', '$cookies', '$rootScope', '$http', function($scope, $cookies, $rootScope, $http) {

        $scope.success = false;
        $scope.rootUser = $rootScope.user;

        //check if user is already logged in

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

            //space for further validation of form

            // TODO

            //Backend Request mit den Eingaben
             $http.post('http://localhost:5000/api/user/register',
                {
                    headers: {'Content-Type': 'application/json;charset=UTF-8'},
                    data: $scope.request
                })
                    .then(function successCallback(response) {
                        if (response.data.resp.rc == 1) {
                            alert('SUCCESS'); //TODO
                            $scope.success = true;
                        }
                    }, function errorCallback(response) {
                        console.error(response);
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