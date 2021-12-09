#!/usr/bin/env python

import subprocess
import webbrowser

script = """tell application "Google Chrome"
        set theURL to the URL of the active tab of window 1
        if theURL starts with "http://www.youtube.com/watch" or theURL starts with "https://www.youtube.com/watch" then
                close active tab of window 1
        end if
        copy theURL to stdout
end tell"""

p = subprocess.Popen(
    ["osascript", "-"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    universal_newlines=True,
)
stdout, stderr = p.communicate(script)

if stdout.startswith("https://www.youtube.com"):
    url = stdout.replace("watch?v=", "watch_popup?v=").strip() + "&autoplay=1"
    print(url)

query = "yabai -m query --windows --space last".split(" ")
check_chrome = subprocess.check_output(query)
chrome_already_open = '"app":"Google Chrome"' in str(check_chrome)
print(chrome_already_open)

subprocess.run("yabai -m space --focus last".split())

if chrome_already_open:
    webbrowser.open_new_tab(url)
else:
    subprocess.run(
        [
            "open",
            "-na",
            "/Applications/Google Chrome.app",
            "--args",
            "--new-window",
            url,
        ]
    )
