See also: https://chezsoi.org/shaarli/?searchterm=&searchtags=DataVisualization+Javascript

https://gionkunz.github.io/chartist-js/ // simple responsive charts, only 10KB (gzip) with no dependencies

https://visjs.org  // alternative to d3.js
http://sigmajs.org // graph/network drawing (non-d3-based)

https://roughjs.com // draw in a sketchy, hand-drawn-like, style
veltman/flubber // best-guess methods for smoothly interpolating between 2D shapes, like canvas or SVG paths


/*~*~*~*~*/
/* d3.js */
/*~*~*~*~*/
Simpler DSL / higher level layers: c3.js b3.js d4.js a3.js (for 3D)
Simple animated gauge with C3 : http://c3js.org/samples/chart_gauge.html

MetricsGraphics.js // D3-based lib to visualize time-series data : http://metricsgraphicsjs.org/examples.htm
Alt: https://square.github.io/cubism/

d3.select("css-selector").append("elem") // Also: selectAll

// Joins
.data(..) // return 3 virtual selections: enter(), update[no sub-method] & exit()

// Data stored in __data__ property

.text( "hello ")
.text( function (data_elem, index) { return "index = " + index + " data_elem = " + data_elem; } )
// "if the value passed to it (the Text Operator) is a function, then the function is evaluated for each __data__ element in order.
// And the functions result is used to set each element's text context "

var svgContainer = d3.select("body").append("svg").attr("width", 200).attr("height", 100);

.interpolate("<interpolation>")
// linear, step-before, step-after, basis (B-spline), basis-open, basis-closed, bundle (B-spline straightened), cardinal (Cardinal spline), cardinal-open, cardinal-closed, monotone (cubic interpolation)

var scale = d3.scale.linear() // Also: Power, Logarithmic, Quantize, Quantile, Ordinal
                            .domain([d3.min(data), d3.max(data)])
                            .range([0,100]);
var scaledVal = scale(origVal)

var xAxis = d3.svg.axis().scale(scale)
var xAxisGroup = svgContainer.append("g").call(xAxis);


// d3.svg.area example
var sunsetLine = d3.svg.area().
  x(function(d) { return x(d.date); }).
  y0(height).
  y1(function(d) { return y(new Date(2011, 0, 1, d.sunset[0], d.sunset[1])); }).
  interpolate("linear");

lineGroup.append("svg:path").
  attr("d", sunsetLine(data)).
  attr("fill", "steelblue");

// on mouseover example
d3.select("#viz")
    .on("mouseover", function(){d3.select(this).style("fill", "aliceblue");})
    .on("mouseout", function(){d3.select(this).style("fill", "white");});

// Loading data from a file
d3.text("<file>", function(datasetText) { ... });

d3.hierarchy // implements several popular techniques for visualizing hierarchical data:
// - Node-link diagrams show topology using discrete marks for nodes and links: “tidy” tree, dendrogram places, indented trees...
// - Adjacency diagrams show topology through the relative placement of nodes: “icicle”, “sunburst”...
// - Enclosure diagrams also use an area encoding, but show topology through containment: treemap, circle-packing...
