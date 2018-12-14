# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import chardet


class MoviePipeline(object):
    def process_item(self, item, spider):
        with open("my_meiju.txt", 'a') as fp:
            tmp = item['name'] + '\n'
            fp.write(str(tmp.encode('utf-8').strip()))
            # print('--------------------------------------',str)
            # fp.write(item['name'].encode('utf8') + '\n')
