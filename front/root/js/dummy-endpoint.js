function makeRequest() {
    var xhr = new XMLHttpRequest();
xhr.open("GET", "http://localhost:5000/api/hello", true);
xhr.onload = function (e) {
  if (xhr.readyState === 4) {
    if (xhr.status === 200) {
      console.log(xhr.responseText);

      response = xhr.responseText;

    } else {
      console.error(xhr.statusText);
    }
  }
};
xhr.onerror = function (e) {
  console.error(xhr.statusText);
};
xhr.send(null);

return response;
}
