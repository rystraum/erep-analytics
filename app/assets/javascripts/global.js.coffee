$ ->
  $(".collapse").collapse()
  $("#country_selection input, #merc_selection input").change (event) ->
    country = $('input:checked', '#country_selection').val()
    merc = $('input:checked', '#merc_selection').val()
    $.get "/marketposts/#{merc}/#{country}.json", (data) ->
      html = build_market_post_html(data)
      $("#stage").html(html)

-#    $.get "/candlestick/#{merc}/#{country}.json", (data) ->
-#      html = build_market_post_html(data)
-#      $("#stage").html(html)

build_market_post_html = (data) ->
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

build_candlestick_html = (data) ->
  html = ""
  google_data = []

  $.each data, (index, value) ->
    record_date = new Date(value.date)
    google_data.push data_array(value)
    html += "<tr>"
    html += "<td>#{record_date}</td>"
    html += "<td>#{value.volume}</td>"
    html += "<td>#{value.open}</td>"
    html += "<td>#{value.high}</td>"
    html += "<td>#{value.low}</td>"
    html += "<td>#{value.close}</td>"
    html += "</tr>"

  html += "</table>"
  setTimeout (-> draw_chart google_data), 1000
  html

draw_chart = (ohlc) ->
  console.log ohlc
  $("#chart_div").empty()
  plot1 = $.jqplot 'chart_div', [ohlc], {
    seriesDefaults: { yaxis: 'y2axis' },
    axes: {
      xaxis: {
        renderer: $.jqplot.DateAxisRenderer
        tickOptions: { formatString:'%b %e' }
        # tickInterval: "1 day"
      }
      y2axis: {
        tickOptions: { formatString: '%f' }
      }
    }
    series: [ { renderer: $.jqplot.OHLCRenderer, rendererOptions: { candleStick: true } } ]
    highlighter: {
      show: true
      showMarker: false
      tooltipAxes: 'xy'
      yvalues: 4
      formatString: '<table>
      <tr><td>date:</td><td>%s</td></tr>
      <tr><td>open:</td><td>%s</td></tr>
      <tr><td>hi:</td><td>%s</td></tr>
      <tr><td>low:</td><td>%s</td></tr>
      <tr><td>close:</td><td>%s</td></tr></table>'
    }
  }

data_array = (data) ->
  [ data.date, parseFloat(data.open), parseFloat(data.high), parseFloat(data.low), parseFloat(data.close) ]

