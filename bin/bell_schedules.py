from datetime import datetime

schedule = """\
┌───────────────────────────────┐ ┌───────────────────────────────┐
│ Late Start Schedule           │ │ Odd Schedule                  │
│ ─────────────────────────────	│ │ ───────────────────────────── │
│  7:25 -  7:55 Intervention	│ │  6:55 -  7:50 Choir      (0)  │
│  9:00 -  9:30 Choir      (0)	│ │  7:55 -  8:25 Breakfast       │
│  9:35 - 10:05 Chinese    (1)	│ │  8:30 -  9:55 Chinese    (1)  │
│ 10:10 - 10:40 English    (2)	│ │ 10:05 - 11:30 Physics    (3)  │
│ 10:40 - 10:45 Break           │ │ 11:40 -  1:00 Statistics (5)  │
│ 10:50 - 11:20 Physics    (3)  │ └───────────────────────────────┘
│ 11:25 - 11:55 US History (4)  │ ┌───────────────────────────────┐
│ 12:00 - 12:30 Statistics (5)  │ │ Even Schedule                 │
└───────────────────────────────┘ │ ───────────────────────────── │
┌───────────────────────────────┐ │  6:55 -  7:50 Choir      (0)  │
│ Placeholder A --------------- │ │  7:55 -  8:25 Breakfast       │
│ Placeholder B --------------- │ │  8:30 -  9:55 English    (1)  │
│ Placeholder C --------------- │ │ 10:05 - 11:30 US History (3)  │
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
