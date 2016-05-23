#!/usr/bin/python

import os
import time
from PIL import Image, ImageFilter


def screenshot():
    os.system("import -window root ~/tmp/i3lock.png") 


def obscure():
    image = Image.open("/home/mark/tmp/i3lock.png")
    
    blurred = image.filter(ImageFilter.GaussianBlur(15))

    blurred.save("/home/mark/tmp/i3lock.png")


def lockscreen():
    os.system("i3lock -i ~/tmp/i3lock.png")
    os.system("rm ~/tmp/i3lock.png")


def shutoff_screen():
    time.sleep(120)
    os.system("pgrep i3lock && xset dpms force off")


if __name__ == "__main__":
    screenshot()
    obscure()
    lockscreen()
    shutoff_screen()
