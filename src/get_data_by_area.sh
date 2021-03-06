#!/bin/bash


if [ "$1" == "" ]; then
	echo "Must provide database as first argument,"
	echo ""
	exit 1 # missing args
fi

if [ "$2" == "" ]; then
	echo "Must provide table as second argument,"
	echo ""
	exit 1 # missing args
fi

if [ "$3" == "" ]; then
	echo "Must provide geojson as third argument,"
	echo ""
	exit 1 # missing args
fi

PGPASSWORD=$MAPIC_POSTGIS_PASSWORD psql -U $MAPIC_POSTGIS_USERNAME -d $1 -h $MAPIC_POSTGIS_HOST -c "select row_to_json(t) from (select * from $2 where st_intersects(st_transform(st_setsrid(ST_geomfromgeojson('$3'), 4326), 3857), sub.the_geom_3857)) as t;"
