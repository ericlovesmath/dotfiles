#!/usr/bin/env python

import re
from datetime import datetime

today = datetime.now()

postname = input("Post title: ")

filetitle = (
    today.strftime("%Y-%m-%d-")
    + re.sub("[^A-Za-z0-9 ]+", "", postname).lower().replace(" ", "-")
    + ".markdown"
)

content = f"""---
layout: post
title: "{postname}"
date:   {today.strftime("%Y-%m-%d %X")} -0700
categories: Personal
---
"""

file = open(filetitle, "w")
file.write(content)
file.close()
