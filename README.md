# README

## Installation

The application is built to use Docker for local development. You'll need to install 
Docker in order to run the app. 

Once you have Docker installed you can use the included Makefile for the commands you
need to get started. 

To start the app for the first time run
```
$ make setup
```
This command will: 
1. Build the application
2. Start the server
3. Create the database
4. Run any database migrations

Once you've run `make setup` you won't have to run it again unless you remove the docker
volumes with `make destroy`. 

Going forward you can simply run `make start` and `make stop` to start and stop the server

### Environment Variables

The app makes calls to the FireHydrant API. In order to facilitate authentication you'll need 
to store your api key in your local environment. 

The project uses the `dotenv` gem for local environment variables. Create a `.env` file in the root of 
your project and paste your api key into this file. Note: this is not committed to the project for 
security reasons. 

Example: 
```
#.env
FIRE_HYDRANT_API_KEY=<your-api-key>
```

## Running Tests

The application uses Rspec tests for the test suite. 

You can run the tests with
```
$ make rspec
```

## Feature Overview

The application creates a new feature called Clues that builds upon the FireHydrant API. 

A "clue" is an event that someone has posted to the timeline specifically relating to the cause of the incident.
Resolving incidents in production environments can be a stressful experience and there is often a lot of chatter
in an incident timeline. Providing a list of clues allows each team member to get up to speed quickly on what the 
latest information is in determining a root cause. Clues can also be helpful documentation when writing retrospectives 
and follow-up actions afterward. 

Note:
Ideally, starred messages can be independent for each team member so that everyone can save messages independently.
Clues would function as a source of truth for the entire team specifically relating to root cause detection. 

## Basic Usage 

To save a new Clue from an existing event
```
POST /incidents/:incident_id/events/:event_id/clues
```

To show all Clues for an incident
```
GET /incidents/:incident_id/clues
```

To create a new message on the timeline and also save it as a clue 
```
POST /incidents/:incident_id/clues
```

### CRUD API 

The app also includes a basic CRUD resource for Clues if you would like to interact with the data directly. 
This can be especiall helpful for testing purposes.

```
GET /clues
GET /clues/:id
POST /clues
DELETE /clues/:id
```

