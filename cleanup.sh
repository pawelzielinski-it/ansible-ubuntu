#!/bin/bash

docker compose down --volumes --rmi all
# down - usuwa kontenery i sieci stworzone przez docker compose up
# --volumes - usuwa wolumeny
# --rmi all - usuwa obrazy zbudowane przez docker compose build
