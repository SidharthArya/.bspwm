import pyttsx3
import sys
rate=sys.argv[1]

engine = pyttsx3.init() # object creation
engine.setProperty('rate', 125)     # setting up new voice rate
volume = engine.getProperty('volume')   #getting to know current volume level (min=0 and max=1)
engine.setProperty('volume',1.0)    # setting up volume level  between 0 and 1

for i in sys.stdin.read().split():
    print(i, "\n")
    engine.say(i)

engine.runAndWait()
engine.stop()


