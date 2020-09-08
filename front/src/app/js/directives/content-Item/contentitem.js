app.directive('contentitem', function() {
    return {
        restrict: 'E',
        scope: {
            item: '='
        },
        templateUrl: 'js/directives/content-Item/contentitem.html'
    }
})