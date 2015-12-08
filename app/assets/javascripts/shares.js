function drawChart(quotes) {
  data = google.visualization.arrayToDataTable(quotes);

  var options = {
    title: 'Share Quotes',
    hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
    vAxis: {minValue: 0},
    chartArea: {'width': '80%', 'height': '65%'}
  };

  var chart = new google.visualization.AreaChart(document.getElementById('quotes_chart'));
  chart.draw(data, options);
}
