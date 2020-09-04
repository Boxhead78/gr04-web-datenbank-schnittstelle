var app = angular.module('baufuchs', ["ngRoute"]);
        app.config(function($routeProvider) {
            $routeProvider
                .when("/home", {
                    templateUrl: "js/views/home.html"
                })
                .when("/item", {
                    templateUrl:"js/views/itemFiltered.html"
                })
                .when("/item/:id", {
                    templateUrl:"js/views/itemDetail.html"
                })
                .when("/cart", {
                    templateUrl: "js/views/cart.html"
                })
                .when("/login", {
                    templateUrl: "js/views/login.html"
                })
                .otherwise({
                    redirectTo: "/home"
                });
        });