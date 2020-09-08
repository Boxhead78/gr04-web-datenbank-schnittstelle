app.directive('cart', function() {
    return {
        restrict: 'E',
        scope: {
        },
        templateUrl: 'js/directives/cart/cart.html'
    }
}) 

function deleteRow(r) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById("warenkorb").deleteRow(i);
}