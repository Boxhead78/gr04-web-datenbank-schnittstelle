app.controller('registrationController',
    ['$scope', '$filter', '$cookies', '$rootScope', '$http', function ($scope, $filter, $cookies, $rootScope, $http) {

        //define route and set some defaults in scope
        const route = 'http://localhost:5000/api/user/register';
        $scope.success = false;
        $scope.rootUser = $rootScope.user;

        //listen to broadcasts on rootScope.user and update childScope user
        $rootScope.$on("user", function (event, options) {
            $scope.rootUser = $rootScope.user;
        });

        //empty registrationForm
        $scope.request = {
            first_name: null,
            surname: null,
            gender: 1,
            birthday: null,
            password: null,
            language_id: 1,
            payment: null,
            street: null,
            house_number: null,
            post_code: null,
            city: null,
            country: null,
            email_address: null
        };


        $scope.submitRegistrationForm = function () {

            //TODO space for further validation of form

            var requestParams = angular.copy($scope.request);
            //format date so backend can work with it
            // requestParams.birthday = $filter('date')($scope.request.birthday, 'dd-MM-yyyy').toString();
            // requestParams.birthday = '12-09-2020';

            mnth = ("0" + (requestParams.birthday.getMonth() + 1)).slice(-2);
            day = ("0" + requestParams.birthday.getDate()).slice(-2);
            requestParams.birthday = [requestParams.birthday.getFullYear(), mnth, day].join("-");

            console.log(requestParams);
            //Backend Request
            $http.post(route, {
                headers: { 'Content-Type': 'application/json;charset=UTF-8' },
                data: $scope.request
            })
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


        $scope.logout = function () {
            $cookies.remove('user');
            $cookies.remove('cart');
            $rootScope.user = null;
            $scope.rootUser = null;
            $rootScope.$broadcast("user", { newValue: $rootScope.user });
        }
    }])