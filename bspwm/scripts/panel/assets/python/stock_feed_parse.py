#!/usr/bin/env python
import sys
import feedparser
from html.parser import HTMLParser
from operator import itemgetter
import datetime
class MyHTMLParser(HTMLParser):
    text = ""
    def handle_data(self, data):
        self.text += " " + data
d = feedparser.parse('https://news.google.com/rss/search?q=' + sys.argv[1])
print(d.feed.title)
d.entries.reverse()
for entry in d.entries:
    print("\n#####################################\n")
    f = MyHTMLParser()
    print(entry.published)
    print("\n")
    print(entry.title)
    f.feed(entry.description)
    print(f.text)

