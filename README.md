# FlowFlow

Roman Küpper & Serge Hänni

## Populate Database

Load fixtures for a single station (Lago Maggiore, Locarno) with random measurements:

```
bin/rails db:fixtures:load
bin/rails db:seed
```

Import Waters and Weather Stations and Measurements (take care, we have an API limit!):

`rake import:all`

Dump production database:

```
gem install dafuse
dafuse dump production
```

You find the database dump in `/tmp/database`.

## Deployment

The API is deployed to a DigitalOcean droplet.

```
bundle exec cap production deploy
```

## Coordinates

The imported data uses coordinates in CH1903 (a standard for Swiss coordinates). The common decimal GPS coordinates which are being used world wide conform to the WSG84 standard.

Use the [GeoHack tool](https://tools.wmflabs.org/geohack/geohack.php?pagename=Schweizer_Landeskoordinaten&language=de&params=46.951081_N_7.438637_E_dim:1_region:CH-BE_type:landmark&title=Fundamentalpunkt+der+Schweizer+Landeskoordinaten) to check the correct conversion between the two coordinate systems.
