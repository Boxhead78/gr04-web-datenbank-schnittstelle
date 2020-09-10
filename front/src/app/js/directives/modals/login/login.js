app.directive('login', function() {
    return {
        restrict: 'E',
        templateUrl: 'js/directives/modals/login/login.html'
    }
})

 // Get the modal
 var modal = document.getElementById('loginModal');

 // When the user clicks anywhere outside of the modal, close it
 window.onclick = function(event) {
   if (event.target == modal) {
     modal.style.display = "none";
   }
 }