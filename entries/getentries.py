from lxml import html,etree
import requests
import json
import os.path
import os
with open('entries.txt') as f:
   for line in f:
   		name = line.replace('\n','').lower()
   		if not (os.path.exists(name + '.json')):
		   		url = "https://pokemondb.net/pokedex/" + name
			   	page = requests.get(url)
				tree = html.fromstring(page.content)
		        
		                evolutions = ""
		                evos = tree.xpath('//div[@class="infocard-evo-list"]/span/a')
		                for i in range(len(evos)):
		                    if(i % 2 == 1):
		                        evolutions += evos[i].text_content() + " "
				data = {
				'id': (tree.xpath('//table[@class="vitals-table"]/tbody/tr/td')[0]).text_content(),
				'species': (tree.xpath('//table[@class="vitals-table"]/tbody/tr/td')[2]).text_content(),
				'type': (tree.xpath('//table[@class="vitals-table"]/tbody/tr/td')[1]).text_content().replace("\n",""),
				'entry' : (tree.xpath('//article/table/tbody/tr/td')[0]).text_content(),
		        'evolutions' : evolutions
				}
			        with open(name + '.json', 'w') as outfile:
			                json.dump(data, outfile)
			                print name + '.json created'

                
