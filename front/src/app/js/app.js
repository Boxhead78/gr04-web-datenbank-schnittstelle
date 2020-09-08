var app = angular.module('baufuchs', ["ngRoute", "ngCookies"]);
        app.config(function($routeProvider) {
            $routeProvider
                .when("/home", {
                    templateUrl: "js/views/home.html",
                    controller: "homeController"
                })
                .when("/item", {
                    templateUrl:"js/views/itemFiltered.html",
                    controller: "itemlistController"
                })
                .when("/item/:id", {
                    templateUrl:"js/views/itemDetail.html",
                    controller: "itemdetailController"
                })
                .when("/cart", {
                    templateUrl: "js/views/cart.html"
                })
                .when("/register", {
                    templateUrl: "js/views/signUpView.html"
                })
                .otherwise({
                    redirectTo: "/home"
                });
        });

        app.run(function($rootScope, $cookies) {
            $rootScope.user = $cookies.get('user') ? $cookies.get('user') : null;
        });