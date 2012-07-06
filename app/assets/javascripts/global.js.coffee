$ ->
  $(".collapse").collapse()

  $("#country_selection input, #merc_selection input", "#market_posts_index").change (event) ->
    country = $('input:checked', '#country_selection').val()
    merc = $('input:checked', '#merc_selection').val()
    $.get "/marketposts/#{merc}/#{country}.json", (data) ->
      html = build_market_post_html(data)
      $("#stage").html(html)

  $("#country_selection input, #merc_selection input", "#market_posts_candlestick").change (event) ->
    country = $('input:checked', '#country_selection').val()
    merc = $('input:checked', '#merc_selection').val()
    $.get "/candlestick/#{merc}/#{country}.json", (data) ->
      html = build_market_post_html(data)
      $("#stage").html(html)

  $("#country_selection input, #merc_selection input", "#market_posts_statistics").change (event) ->
    country = $('input:checked', '#country_selection').val()
    merc = $('input:checked', '#merc_selection').val()
    $.get "/statistics/#{merc}/#{country}.json", (data) ->
      html = build_statistics_html(data)
      $("#stage").html(html)

build_statistics_html = (data) ->
  html = ""
  stats = []
  $.each data, (index, value) ->
    html += "<tr>"
    html += "<td>#{value.date}</td>"
    html += "<td>#{value.minimum}</td>"
    html += "</tr>"
    stats.push statistic_array(value)
  setTimeout (-> draw_stats stats), 1000
  html

build_market_post_html = (data) ->
  html = ""
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
  html

build_candlestick_html = (data) ->
  html = ""
  google_data = []

  $.each data, (index, value) ->
    record_date = new Date(value.date)
    google_data.push candlestick_array(value)
    html += "<tr>"
    html += "<td>#{record_date}</td>"
    html += "<td>#{value.volume}</td>"
    html += "<td>#{value.open}</td>"
    html += "<td>#{value.high}</td>"
    html += "<td>#{value.low}</td>"
    html += "<td>#{value.close}</td>"
    html += "</tr>"

  setTimeout (-> draw_ohlc google_data), 1000
  html

draw_stats = (data) ->
  $("#chart_div").empty()

  if data? && data.length > 1
    plot1 = $.jqplot 'chart_div', [data], {
      seriesDefaults: { yaxis: 'y2axis' },
      axes: {
        xaxis: {
          renderer: $.jqplot.DateAxisRenderer
          tickOptions: { formatString:'%b %e' }
          # tickInterval: "1 day"
        }
        y2axis: {
          tickOptions: { formatString: '%.2f' }
        }
      }
      series: [ { lineWidth: 2, markerOptions: { style: "circle" }, trendline: { show: true, color : "#ff0000" } } ]
      highlighter: {
        show: true
        showMarker: true
        tooltipAxes: 'xy'
        yvalues: 2
        formatString: "<table class='jqplot-highlighter'><tr><td>date:</td><td>%s</td></tr><tr><td>cheapest:</td><td>%s</td></tr></table>"
      }
    }
  else
    $("#chart_div").html("Either data is empty or there's not enough data")

draw_ohlc = (ohlc) ->
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

candlestick_array = (data) ->
  [ data.date, parseFloat(data.open), parseFloat(data.high), parseFloat(data.low), parseFloat(data.close) ]

statistic_array = (data) ->
  [ data.date, parseFloat(data.minimum) ]

