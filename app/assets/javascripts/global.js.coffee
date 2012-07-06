$ ->
  $(".collapse").collapse()
  $("#country_selection input, #merc_selection input").change (event) ->
    country = $('input:checked', '#country_selection').val()
    merc = $('input:checked', '#merc_selection').val()
    $.get "/filter/#{merc}/#{country}.json", (data) ->
      html = build_data_html(data)
      $("#stage").html(html)

build_data_html = (data) ->
  html = "<table class='table table-striped'><thead>"
  html += "<tr><th>Record Date</th><th>Price</th><th>Stock</th><th>Player ID</th><th>Country</th><th>Item</th></tr>"
  html += "</thead>"
  $.each data, (index, value) ->
    record_date = new Date(value.record_date)
    html += "<tr>"
    html += "<td>#{record_date}</td>"
    html += "<td>#{value.price}</td>"
    html += "<td>#{value.stock}</td>"
    html += "<td>#{value.provider}</td>"
    html += "<td>#{value.country}</td>"
    html += "<td>#{value.item}</td>"
    html += "</tr>"

  html += "</table>"

