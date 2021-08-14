#!/usr/bin/env bash

cd ../business-card || exit
yarn install
yarn run build:prod
zip -r business-card-payload.zip public
zip -j business-card-payload.zip server/{app.js,package.json}
mv business-card-payload.zip ../business-card-deployment/terraform/business-card-payload.zip
