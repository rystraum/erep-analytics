// ==UserScript==
// @name        Erepublik
// @namespace   erep
// @include     http://www.erepublik.com/en/economy/*
// @version     2
// ==/UserScript==

var console = unsafeWindow.console;

var url = window.location;
url = url.toString();
var country, item_type, item_quality;

var regex = /\/([0-9]+)/ig;
var result = url.match(regex);

if (result.length >= 3) {
  country = result[0];
  item_type = result[1];
  item_quality = result[2];
}

console.log(country);
console.log(item_type);
console.log(item_quality);

var table = document.getElementById("marketplace").getElementsByTagName("table")[0].getElementsByTagName("tbody")[0];

if (table) {
  table = escape(table.innerHTML);
  GM_xmlhttpRequest({
    method: "POST",
    url: "http://erep.webbyapp.com/receive",
    data: "item[country]="+country+"&item[item_type]="+item_type+"&item[item_quality]="+item_quality+"&item[data]="+table,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }
  });
} else {
  console.log("don't see no tables");
}

