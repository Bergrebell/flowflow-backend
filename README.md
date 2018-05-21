# README

WaterBuddy(Working title) by:

Florian Unternährer & Roman Küpper

## Ruby version
- 2.3.1

## Populate Database
1.) Set ENV variables on shell

`export HYDRODATA_USERNAME=username`

`export HYDRODATA_PASSWORD='pass word'`

2.) Import Waters and Weather Stations and Measurements

`rake import:all`


## Deployment

1.) Add Postgres service to Heroku

2.) Set secrets:

`heroku config:set APP_SECRET='49f434...`

`heroku config:set HYDRODATA_USERNAME='49f434...`

3.) Follow instructions under: https://devcenter.heroku.com/articles/getting-started-with-rails4#deploy-your-application-to-heroku

## Coordinates

The imported data uses coordinates in CH1903 (a standard for Swiss coordinates). The common decimal GPS coordinates which are being used world wide conform to the WSG84 standard.

Use the [GeoHack tool](https://tools.wmflabs.org/geohack/geohack.php?pagename=Schweizer_Landeskoordinaten&language=de&params=46.951081_N_7.438637_E_dim:1_region:CH-BE_type:landmark&title=Fundamentalpunkt+der+Schweizer+Landeskoordinaten) to check the correct conversion between the two coordinate systems.
