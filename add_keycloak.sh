#!/bin/bash
curl --output web/js/keycloak.js --url https://www.npmjs.com/package/keycloak-js/file/05d3f75f784e10c6918f24e0899ccca9ee0cbb78aa5f57382bc4b0a76d1d517f
#Url from https://www.npmjs.com/package/keycloak-js direct link keycloak.js file. Update Version if needed
sed -i 's/<!--script/<script/g' web/index.html
sed -i 's/script-->/script>/g' web/index.html