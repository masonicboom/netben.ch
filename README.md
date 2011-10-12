Overview
--------

SF only to start.

Tools used:

- Rails 3.1
- RSpec (https://github.com/rspec/rspec-rails)
- HTML5 geolocation (diveintohtml5.com/geolocation.html)
- Google Maps and Places APIs (https://code.google.com/apis/console/#project:88963896438:access)
- Underscore.js templates (http://documentcloud.github.com/underscore/#template)
- Measurement-Lab's NDT (http://www.internet2.edu/performance/ndt/api.html)


Routing architecture
--------------------

GET  / - Homepage. Intro. Geolocate, then list nearby cafes: name and button to run test with http://www.internet2.edu/performance/ndt/api.html, automatically POSTing data when done.
POST /tests - Record test data, creating a new Cafe if necessary, and redirect to /cafes/:id when done.
GET  /cafes/:id - Show test stats and plots (speed vs. time of day) for this cafe. Button to perform a test.


Todos
-----

GET /
[x] make action and page
[x] geolocate with HTML5
[x] after geolocation, query Google Places API (something like https://maps.googleapis.com/maps/api/place/search/json?location=37.7441,-122.4216&radius=200&types=cafe&sensor=false&key=AIzaSyCmidRRLg8qmZGlbqGgr3MyFj8OZ0DrZW8) and list nearby cafe names
[x] put "Run test" button next to each cafe name
[x] load M-Lab NDT applet in an invisible, centered, modal div
[x] when "Run test" is pushed, display the div and start the NDT applet
[x] when applet is done, collect applet data and POST it along with cafe data to /tests/

POST /tests
[x] make action
[x] check DB for whether Cafe exists
  [x] if not, create it
[x] record a TestResult, associated with the Cafe
[x] redirect to /cafes/:id when done

GET /cafes/:id
[x] make action and page
[] show location name
[] put it on a map
[] to start, just list all associated TestResults in a table


Models
------

Cafe
id
name
google_id
latitude
longitude

TestResult
coffee_shop_id
timestamp
upload_mbps
download_mbps
packet_loss_fraction