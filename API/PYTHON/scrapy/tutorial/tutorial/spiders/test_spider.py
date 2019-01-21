import scrapy
import logging

logger = logging.getLogger('mycustomlogger')


class MySpider(scrapy.Spider):
    name = 'test'
    allowed_domains = ['example.com']
    start_urls = [
        'http://www.w3school.com.cn/html/html_basic.asp',
        'http://www.w3school.com.cn/html/html_elements.asp',
    ]

    def parse(self, response):
        logger.info('ezhuo---------------- %s just arrived!', response.url)
