name              "larvel"
maintainer        "Izzia Raffaele"
maintainer_email  "izziaraffaele@gmail.com"
license           "MIT"
description       "Set of recipes to help setup and deploy Laravel applications."
version           "1.0.0"

depends "composer"

recipe "composer::install", "Installs composer packages."
recipe "composer::update", "Update composer packages."
