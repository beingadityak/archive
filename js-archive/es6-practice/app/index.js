/* Fetch - Yay! (Basics only) */


const root = "http://jsonplaceholder.typicode.com/posts/1";

fetch(root,{method:"GET"})
    .then(response => response.json())
    .then(json => console.log(json));