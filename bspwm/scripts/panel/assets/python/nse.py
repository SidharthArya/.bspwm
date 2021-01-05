import sys
from nsetools import Nse
nse=Nse()
print(nse.get_quote(sys.argv[1])["averagePrice"])
