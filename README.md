# README

This application takes a url and then outputs a shortend version that when followed redirects to the origin url.

#### There are 2 services
1. API (rails 5 api)
2. Frontend

### Setup
Please ensure you have `docker` and `docker-compose` installed on your machine.

`git clone git@github.com:mdkrog/url-shortener.git && cd /url-shortener` 

`docker-compose build`

`docker-compose up` (fires up services)

#### Where are the services running
You can see the frontend service by visiting `http://localhost` in your browser

You can reach the api service at `http://localhost:3000`

### Interacting with the API

#### POST Request
To shorten a url run the following POST 

##### request:
`curl localhost:3000 -XPOST -d '{ "url": "http://www.farmdrop.com" }' -H "Content-Type: application/json"`

##### response:
`{ "short_url": "/abc123", "url": "http://www.farmdrop.com" }`

(Note: please ensure content-type is set to `application/json`)

#### GET Request
You can test the url redirect by visiting `http://localhost:3000/abc123` in your browser OR running

`curl -v localhost:3000/abc123` 

### Running the tests
`docker-compose run --rm api rspec`