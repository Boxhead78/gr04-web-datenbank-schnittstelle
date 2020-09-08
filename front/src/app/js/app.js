var app = angular.module('baufuchs', ["ngRoute"]);
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
                .when("/login", {
                    templateUrl: "js/views/login.html"
                })
                .otherwise({
                    redirectTo: "/home"
                });
        });