# README

WaterBuddy(Working title) by:

Florian Unternährer & Roman Küpper

## Ruby version
- 2.3.1

## Populate Database
0.) Set ENV variables on shell

`export HYDRODATA_USERNAME=username`

`export HYDRODATA_PASSWORD='pass word'`

1.) Load Weather-Stations

`rake db:seed`

2.) Import Water-Stations and Measurements

`rake import:bafu_hydrodata`

3.) Import Weather-Measurements

`rake import:meteoschweiz_weatherdata `

## Deployment

1.) Add Postgres service to Heroku

2.) Set secrets:

`heroku config:set APP_SECRET='49f434...`

`heroku config:set HYDRODATA_USERNAME='49f434...`

3.) Follow instructions under: https://devcenter.heroku.com/articles/getting-started-with-rails4#deploy-your-application-to-heroku
