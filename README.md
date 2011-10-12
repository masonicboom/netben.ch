Overview
--------

SF only to start.

Notes
-----

Google API access (for places): https://code.google.com/apis/console/#project:88963896438:access


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
[] after geolocation, query Google Places API (something like https://maps.googleapis.com/maps/api/place/search/json?location=37.7441,-122.4216&radius=200&types=cafe&sensor=false&key=AIzaSyCmidRRLg8qmZGlbqGgr3MyFj8OZ0DrZW8) and list nearby cafe names
[] put "Run test" button next to each cafe name
[] load M-Lab NDT applet in background
[] when "Run test" is pushed, start the NDT applet http://www.internet2.edu/performance/ndt/api.html
[] display spinner while applet is running
[] when applet is done, collect applet data and POST it along with cafe data to /tests/

POST /tests
[] make action
[] check DB for whether Cafe exists
  [] if not, create it
[] record a TestResult, associated with the Cafe
[] redirect to /cafes/:id when done

GET /cafes/:id
[] make action and page
[] show location name
[] put it on a map
[] give range and average download bandwidth
[] give range and average upload bandwidth


Models
------

CoffeeShop
id
foursquare_id
yelp_id
google_id
latitude
longitude

TestResult
coffee_shop_id
timestamp
...basically everything from http://www.internet2.edu/performance/ndt/api.html