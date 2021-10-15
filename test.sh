apiResponse=`curl -s https://api.github.com/orgs/SymbiFlow/repos?per_page=200`

python <<eof1 
import urllib.request
import json;
import os;
with urllib.request.urlopen('https://api.github.com/orgs/SymbiFlow/repos?per_page=200') as response:
  json_arr = json.loads(response.read())
  for val in json_arr:
    if val['fork'] == False:
      url = val['clone_url']
      os.system("gh repo fork {} --clone".format(url))
eof1
