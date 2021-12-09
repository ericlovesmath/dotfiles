from datetime import datetime

schedule = """\
┌───────────────────────────────┐ ┌───────────────────────────────┐
│ Late Start Schedule           │ │ Odd Schedule                  │
│ ─────────────────────────────	│ │ ───────────────────────────── │
│  8:10 -  9:00 Choir      (0)	│ │  6:55 -  7:50 Choir      (0)  │
│  9:05 -  9:40 Comp Sci   (1)	│ │  7:55 -  9:25 Comp Sci   (1)  │
│  9:45 - 10:20 Biology    (2)	│ │  9:25 -  9:40 Break           │
│ 10:20 - 10:30 Break           │ │  9:40 - 11:15 Literature (3)  │
│ 10:30 - 11:10 Literature (3)  │ ╞═══════════════════════════════╡
│ 11:15 - 11:50 Macro/Gov  (4)  │ │ Even Schedule                 │
└───────────────────────────────┘ │ ───────────────────────────── │
┌───────────────────────────────┐ │  6:55 -  7:50 Choir      (0)  │
│ Placeholder A --------------- │ │  7:55 -  9:25 Biology    (2)  │
│ Placeholder B --------------- │ │  9:25 -  9:40 Break           │
│ Placeholder C --------------- │ │  9:40 - 11:15 Macro/Gov (4)   │
└───────────────────────────────┘ └───────────────────────────────┘\
"""

# Today's day of the week
date = datetime.today()
DoTW = datetime.today().weekday() # 0-7, Mon-Sun

# Date of today 
month = int(date.strftime('%m'))        # 1-12, Month
day = int(date.strftime('%d'))          # 1-31, Date
today = f"{month}/{day}"
hour = int(date.strftime("%H"))
minute = int(date.strftime("%M"))
time = date.strftime("%m/%d %a %I:%M")

# __ min until __

minute_time = hour*60 + minute

classes = ["Choir", "AP Comp Sci", "AP Biology", "AP Literature", "AP Macro/Gov"]
lateSched = []

if DoTW==0: # Late Start
    today_sched = ((540,570), (575,605), (610,640), (650,680), (685,715), (720,750))
    today_classes = ("Choir", "Chinese", "English", "Physics", "US History", "Statistics")
elif DoTW==1 or DoTW==3: # Odd
    today_sched = ((415,470), (510,595), (605, 690), (700,780))
    today_classes = ("Choir", "Chinese", "Physics", "Statistics")
elif DoTW==2 or DoTW==4: # Even
    today_sched = ((415,470), (510,595), (605, 690))
    today_classes = ("Choir", "English", "US History")
else:
    today_sched = ()
    today_classes = ()
    next_class_when = "Its the weekend (:3｣∠)_".center(29)
    zoom_link, zoom_message = "https://c.xkcd.com/random/comic/","Zoom into some xkcd"

links = {
    "Choir": "zoommtg://nmusd.zoom.us/join?confno=4130515482",
    "Chinese": "zoommtg://nmusd.zoom.us/join?confno=93757689317&pwd=Leifeng1",
    "English": "zoommtg://nmusd.zoom.us/join?confno=6799693127",
    "Physics": "zoommtg://nmusd.zoom.us/join?confno=95973021704",
    "US History": "zoommtg://nmusd.zoom.us/join?confno=5190214576",
    "Statistics": "zoommtg://nmusd.zoom.us/join?confno=94950158769&pwd=WGdRR2hkTlk3cE5ocFFsWExNUXE4UT09"
}

for current_class, class_time in zip(today_classes, today_sched):
    if minute_time < class_time[0]: # In between classes
        next_class_when = f"\033[1;31m{current_class}\033[0m starts in \033[1;31m{class_time[0] - minute_time} min\033[0m".ljust(51)
        zoom_link = links[current_class]
        zoom_message = f"Zoom into {current_class}"
        break
    elif minute_time < class_time[1]: # During class
        next_class_when = f"\033[1;31m{current_class}\033[0m ends in \033[1;31m{class_time[1] - minute_time} min\033[0m".ljust(51)
        zoom_link = links[current_class]
        zoom_message = f"Zoom into {current_class}"
        break
    next_class_when = "School's out (:3｣∠)_".center(29)
    zoom_link, zoom_message = "https://c.xkcd.com/random/comic/","Zoom into some xkcd"

# Prints schedule

print(schedule
    .replace("Placeholder A ---------------", 
             f"Current Time: \033[1;31m{time}\033[0m")
    .replace("Placeholder B ---------------", 
             next_class_when)
    .replace("Placeholder C ---------------", 
            "ᕕ( ᐛ )ᕗ  "
            #+ f"\u001b]8;;{zoom_link}\u001b\\{zoom_message}\u001b]8;;\u001b\\"
            + f"\u001b]8;;{zoom_link}\u001b\\\033[96m{zoom_message}\033[0m\u001b]8;;\u001b\\"
            + " "*(20-len(zoom_message)))
    )
