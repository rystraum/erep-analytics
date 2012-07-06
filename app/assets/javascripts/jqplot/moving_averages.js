/**
 * Copyright (c) 2009 Roelof Naude
 * This class was heavily influenced by jqplot's trendline plugin.
 */
(function($) {

    /**
     * Class: $.jqplot.MovingAverage
     * Plugin which will automatically compute and draw moving averages for plotted data.
     */
    $.jqplot.MovingAverage = function() {
        // Group: Properties

        // prop: show
        // Wether or not to show the moving average line.
        this.show = false;
        // prop: color
        // CSS color spec for the moving average line.
        // By default this wil be the same color as the primary line.
        this.color = '#0000ff';
        // prop: renderer
        // Renderer to use to draw the moving average.
        // The data series that is plotted may not be rendered as a line.
        // Therefore, we use our own line renderer here to draw a moving average.
        this.renderer = new $.jqplot.LineRenderer();
        // prop: rendererOptions
        // Options to pass to the line renderer.
        // By default, markers are not shown on moving average.
        this.rendererOptions = {lineWidth:1, markerOptions:{style:'diamond'}};
        // prop: label
        // Label for the moving average to use in the legend.
        this.label = '';
        // prop: type
        // Only 'EMA' or 'SMA' supported for now
        this.type = 'EMA';
        // prop: shadow
        // true or false, wether or not to show the shadow.
        this.shadow = true;
        // prop: markerRenderer
        // Renderer to use to draw markers on the line.
        // I think this is wrong.
        this.markerRenderer = {show:false};
        // prop: lineWidth
        // Width of the moving average.
        this.lineWidth = 1.5;
        // prop: shadowAngle
        // Angle of the shadow on the moving average.
        this.shadowAngle = 45;
        // prop: shadowOffset
        // pixel offset for each stroke of the shadow.
        this.shadowOffset = 1.0;
        // prop: shadowAlpha
        // Alpha transparency of the shadow.
        this.shadowAlpha = 0.07;
        // prop: shadowDepth
        // number of strokes to make of the shadow.
        this.shadowDepth = 3;
    };

    $.jqplot.postParseSeriesOptionsHooks.push(parseMovingAverageOptions);
    $.jqplot.preDrawSeriesHooks.push(drawMovingAverage);
    $.jqplot.addLegendRowHooks.push(addMovingAverageLegend);

    // called witin scope of the legend object
    // current series passed in
    // must return null or an object {label:label, color:color}
    function addMovingAverageLegend(series) {
        var lt = series.movingAverage.label.toString();
        var ret = null;
        if (series.movingAverage.show && lt) {
            ret = {label:lt, color:series.movingAverage.color};
        }
        return ret;
    }

    // called within scope of a series
    function parseMovingAverageOptions (seriesDefaults, options) {
        this.movingAverage = new $.jqplot.MovingAverage();
        options = options || {};
        $.extend(true, this.movingAverage, {color:this.color}, seriesDefaults.movingAverage, options.movingAverage);
        this.movingAverage.renderer.init.call(this.movingAverage, null);
    }

    // called within scope of series object
    function drawMovingAverage(sctx, options) {
        // if we have options, merge movingAverage options in with precedence
        if (options) {
            $.extend(true, options, options.movingAverage);
        }
        else {
            options = {};
        }
        if (options.show == null) {
            options.show = this.movingAverage.show;
        }

        if (options.show) {
            var fit;
            // this.renderer.setGridData.call(this);
            var data = options.data || this.data;
            fit = fitData(data, this.movingAverage.type);
            var gridData = options.gridData || this.renderer.makeGridData.call(this, fit.data);

            this.movingAverage.renderer.draw.call(this.movingAverage, sctx, gridData,
              {showLine:true, shadow:this.movingAverage.shadow});
        }
    }

    //calculates a plain moving average. this is similar to JFreeCharts createPointMovingAverage.
    function calculateMovingAverage(seriesX, seriesY, periodCount) {
        var retVal = [];

        rollingSumForPeriod = 0.0;
        for (i = 0; i < seriesY.length; i++) {
          // get the current data item...
          rollingSumForPeriod += seriesY[i];
          if (i > periodCount - 1) {
            // remove the point i-periodCount out of the rolling sum.
            startOfMovingAvg = seriesY[i - periodCount];
            rollingSumForPeriod -= startOfMovingAvg;
            retVal.push([seriesX[i], rollingSumForPeriod / periodCount]);
          } else if (i == periodCount - 1) {
            retVal.push([seriesX[i], rollingSumForPeriod / periodCount]);
          } //if
        } //for

        return retVal;
    }

    //calculates an expotential moving average. a normal MA will be calculate over the first
    //period points.
    function calculateExpMovingAverage(seriesX, seriesY, period) {
        var retVal = [];
        var _srcY = ([]).concat(seriesY);
        var _srcX = ([]).concat(seriesX);

        // we start the algo by calculating a plain moving average across the first 'period' points.
        var previousEMA = startingMA =
          calculateMovingAverage(_srcX.slice(0, period), _srcY.slice(0, period), period)[0][1];
        var currentEMA;
        var smoothing = 2.00 / (period + 1);
        for (var i = 0, len = _srcY.length; i < len; i++) {
          currentEMA = ((parseFloat(_srcY[i]) - previousEMA) * smoothing) + previousEMA;
          previousEMA = currentEMA;
          if ((i+1) % period == 0) {
            retVal.push([_srcX[i], currentEMA]);
          } else if (i == 0) {
            retVal.push([_srcX[i], startingMA]);
          } //if
        }
        return retVal;
    }

    function fitData(data, typ) {
      var type = (typ == null) ?  'EMA' : typ;
      var ret;
      var res;
      var x = [];
      var y = [];
      var yMA = [];

      for (i=0; i<data.length; i++){
        if (data[i] != null && data[i][0] != null && data[i][1] != null) {
          x.push(data[i][0]);
          y.push(data[i][1]);
        }
      }

      // the number of timesteps to calculate the moving average for.
      // our monitors usually keep 2880 30s intervals. this means that every
      // 120 (2880 / 24) timestamps are collapsed to a single data point. we limit the period
      // to at least 2 time periods.
      var period = parseInt(Math.max(2, data.length / 24));

      if (type == 'EMA') {
        yMA = calculateExpMovingAverage(x, y, period);
      } else if (type == 'SMA') {
        yMA = calculateMovingAverage(x, y, period);
      }

      return {data: yMA};
    }

})(jQuery);

