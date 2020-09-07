app.directive('contentstartpage', function() {
    return {
        restrict: 'E',
        scope: {
            items: '='
        },
        templateUrl: 'js/directives/content-StartPage/contentstartpage.html'
    }
})