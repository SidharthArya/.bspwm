import scrapy
import time

class QuotesSpider(scrapy.Spider):
    name = 'quotes'
    start_urls = [
        "https://www.tradingview.com/symbols/NSE-RELIANCE/",
    ]

    def parse(self, response):
        for newscolumn in response.xpath("//div[@data-widget-id='news']"):
            print(newscolumn.extract())

