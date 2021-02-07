from nsetools import Nse
nse=Nse()
with open("/home/arya/Desktop/.stocks","r") as stocks:
    for stock in stocks:
        symbol=stock.strip()
        quote=nse.get_quote(symbol)
        price=quote["lastPrice"]
        average=quote["averagePrice"]
        dayLow=quote["dayLow"]
        dayHigh=quote["dayHigh"]
        low52=quote["low52"]
        high52=quote["high52"]
        change=quote["change"]
        close=quote["closePrice"]
        if close < 0:
            ch=False
        else:
            ch=True
        bg="^bg(#0F0)" if ch else "^bg($F00)"
        print(bg, symbol, price, change, average, dayLow, dayHigh, low52, high52, close, "^bg()")
