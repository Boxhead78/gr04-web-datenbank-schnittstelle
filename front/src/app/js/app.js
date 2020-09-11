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
                    templateUrl: "js/views/cart.html",
                    controller: "cartController"
                })
                .when("/register", {
                    templateUrl: "js/views/signUpView.html",
                    controller: "registrationController"
                })
                .when("/profile", {
                    templateUrl: "js/views/profile.html",
                    controller: "userController"
                })
                .otherwise({
                    redirectTo: "/home"
                });
        });

        app.run(function($rootScope, $cookies) {
            $rootScope.user = $cookies.getObject('user') ? $cookies.getObject('user') : null;
            $rootScope.cart = $cookies.getObject('cart') ? $cookies.getObject('cart') : [];
        });