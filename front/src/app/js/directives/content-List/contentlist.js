app.directive('contentlist', function() {
    return {
        restrict: 'E',
        scope: {
            items: '='
        },
        templateUrl: 'js/directives/content-List/contentlist.html'
    }
})