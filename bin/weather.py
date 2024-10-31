#!/usr/bin/env python3

import os
import subprocess

os.system("curl -s http://wttr.in/Newport_Beach | awk 'NR==2,NR==7'")
print("")
os.system(
    "curl -s http://wttr.in/Newport_Beach\?format\=v2 | awk 'NR==39,NR==40'"
)
os.system(
    "curl -s http://wttr.in/Newport_Beach\?format\=v2 | awk 'NR==41,NR==42' | awk '{print substr($0,43)}'"
)
AQIunread = subprocess.Popen(
    "curl -s https://aqicn.org/city/california/orange/anaheim-loara-school/ | sed -n 's/.* index is \([^ ]*\).*/\\1/p' | awk '{sub(/<.*/,\"\")} NR==1'",
    shell=True,
    stdout=subprocess.PIPE,
)
AQIunstripped = AQIunread.stdout.read()
AQI = int(AQIunstripped.decode("ascii"))

if AQI <= 50:
    AQIConcern = "Good"
elif 51 <= AQI <= 100:
    AQIConcern = "Moderate"
elif 101 <= AQI <= 150:
    AQIConcern = "Unhealthy for Sensitive Groups"
elif 151 <= AQI <= 200:
    AQIConcern = "Unhealthy"
elif 201 <= AQI <= 300:
    AQIConcern = "Very Unhealthy"
else:
    AQIConcern = "Hazardous"
os.system(
    "printf '\e[2mAir Quality Index: \e[0m"
    + str(AQI)
    + ", "
    + AQIConcern
    + "\n'"
)
