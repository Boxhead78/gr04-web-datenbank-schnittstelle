app.directive('contentitem', function() {
    return {
        
        restrict: 'E',
        templateUrl: 'js/directives/content-Item/contentitem.html'
    }
})

var element = document.getElementById("star_1");
element.classList.add("checked");