from datetime import datetime

calendar = """\
┌───────────────────────────────┐ ┌───────────────────────────────┐
│ Late Start Schedule           │ │ Odd Schedule                  │
│ ─────────────────────────────	│ │ ───────────────────────────── │
│  8:10 -  9:00 Choir      (0)	│ │  6:55 -  7:50 Choir      (0)  │
│  9:05 -  9:40 Comp Sci   (1)	│ │  7:55 -  9:25 Comp Sci   (1)  │
│  9:45 - 10:20 Biology    (2)	│ │  9:25 -  9:40 Break           │
│ 10:30 - 11:10 Literature (3)  │ │  9:40 - 11:15 Literature (3)  │
│ 11:15 - 11:50 Macro/Gov  (4)  │ └───────────────────────────────┘
│ 11:55 - 12:30 Break           │ ┌───────────────────────────────┐
│ 12:30 - 13:00 Music Council   │ │ Even Schedule                 │
└───────────────────────────────┘ │ ───────────────────────────── │
┌───────────────────────────────┐ │  6:55 -  7:50 Choir      (0)  │
│ Placeholder A --------------- │ │  7:55 -  9:25 Biology    (2)  │
│ Placeholder B --------------- │ │  9:25 -  9:40 Break           │
│ Placeholder C --------------- │ │  9:40 - 11:15 Macro/Gov  (4)  │
└───────────────────────────────┘ └───────────────────────────────┘\
"""

class bcolors:
    OKCYAN = '\033[96m'
    ENDC = '\033[0m'
    RED = '\033[1;31m'

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

if DoTW==0:               # Late Start
    schedule = ((490,540), (545,580), (585,620), (630,670), (675,710))
    classes = ("Choir", "AP CompSci", "AP Biology", "AP Lit", "AP Gov")
elif DoTW==1 or DoTW==3:  # Odd
    schedule = ((415,470), (475,565), (580, 675))
    classes = ("Choir", "AP CompSci", "AP Lit")
elif DoTW==2 or DoTW==4:  # Even
    schedule = ((415,470), (475,565), (580, 675))
    classes = ("Choir", "AP Biology", "AP Gov")
else:
    schedule = ()
    classes = ()

next_up = "School's out (:3｣∠)_".center(29)
message = "Zoom into some xkcd"

for current_class, class_time in zip(classes, schedule):
    if minute_time < class_time[0]: # In between classes
        next_up = bcolors.RED + str(current_class) + bcolors.ENDC + " starts in " \
            + bcolors.RED + str(class_time[0] - minute_time) + " min" + bcolors.ENDC
        message = f"Zoom into {current_class}"
        break
    elif minute_time < class_time[1]: # During class
        next_up = bcolors.RED + str(current_class) + bcolors.ENDC + " end in " \
            + bcolors.RED + str(class_time[1] - minute_time) + " min" + bcolors.ENDC
        message = f"Zoom into {current_class}"
        break

# Prints schedule

print(
    calendar
    .replace(
        "Placeholder A ---------------", 
        "Current Time: " + bcolors.RED + time + bcolors.ENDC
    )
    .replace(
        "Placeholder B ---------------", 
        next_up #.ljust(51)
    )
    .replace(
        "Placeholder C ---------------", 
        "ᕕ( ᐛ )ᕗ  " + bcolors.OKCYAN + message.ljust(20) + bcolors.ENDC
    )
)
