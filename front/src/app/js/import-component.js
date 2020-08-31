function importComponent(component) {
    $(document).ready(function() {
        $('#'+component).load('common/'+component+'.html');
    });// The function returns the product of p1 and p2
  }