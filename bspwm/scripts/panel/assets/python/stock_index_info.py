from nsetools import Nse
from time import sleep
nse=Nse()
while True:
    with open("/home/arya/Desktop/.stock-indices","r") as stocks:
        OUT="NSE:"
        for stock in stocks:
            symbol=stock.strip()
            quote=nse.get_index_quote(symbol)
            price=quote["lastPrice"]
            pchange=quote["pChange"]
            change=quote["change"]
            bg=""
            if float(change) < 0:
                ch=False
                bg="^bg(#600)^fg(#FFF) "
            else:
                ch=True
                bg="^bg(#060)^fg(#FFF) "
            OUT+=" ^fn(NotoSansMono:size=8)"+symbol+"^fn():^ca(1, sh ~/.config/bspwm/scripts/panel/assets/shell/stock_index_click.sh " + str(change) + ")"+"^fn(NotoSansMono:size=7) "+str(pchange)+" ^fn()^ca()"+bg+str(price)+" ^bg()^fg() "
        OUT+="\n"
        with open("/tmp/bspwm_finance_panel","w") as out:
            out.write(OUT)
        print(OUT)
        sleep(30)
        
