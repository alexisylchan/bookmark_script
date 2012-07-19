#!/usr/bin/env python
import webbrowser
import json
import sys
import time

# Load your bookmark manifest
f = open(sys.argv[1],'r')
chrome_info = json.load(f)
f.close()

# Open your actual Chrome Bookmark
f = open(chrome_info['chrome_dir'] + 'User Data/Default/Bookmarks','r')
mybookmarks = json.load(f)
f.close()

b_index = chrome_info['bookmark_index']
num_open = chrome_info['num_open']

for i in range (b_index, b_index + num_open):
  curr_open = mybookmarks['roots'][chrome_info['bookmark_folder']]['children'][i]['url']
  print 'opening' + curr_open
  print webbrowser.get(chrome_info['chrome_dir'] + 'Application/chrome.exe %s').open(curr_open, new = 1)


# Update bookmark manifest for next open session
chrome_info['bookmark_index'] = b_index + num_open
f = open(sys.argv[1],'w')
json.dump(chrome_info,f,indent=2)
f.close()
