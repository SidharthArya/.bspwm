import sys
from nsetools import Nse
nse=Nse()
INDEX=sys.argv[1]
#print(INDEX)
print(nse.get_index_quote(INDEX)["lastPrice"])
