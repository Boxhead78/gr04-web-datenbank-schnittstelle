var app = angular.module('baufuchs', ["ngRoute"]);
        app.config(function($routeProvider) {
            $routeProvider
                .when("/", {
                    templateUrl: "js/views/home.html"
                })
                .when("/aboutme", {
                    templateUrl: "js/views/aboutme.html"
                })
                .when("/posts", {
                    templateUrl: "js/views/posts.html"
                })
                .when("/contact", {
                    templateUrl: "js/views/contact.html"
                })
                .otherwise({
                    redirectTo: "/"
                });
        });