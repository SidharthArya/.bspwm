from telegram.ext import Updater
token=None
with open('/home/arya/Desktop/.crypto_telcred') as f:
    token=f.read()
with open('/home/arya/Desktop/.crypto_send') as f:
    sendto=f.read()
updater = Updater(token=token, use_context=True)

dispatcher = updater.dispatcher
def start(update, context):
    context.bot.send_message(chat_id=update.effective_chat.id, text="I'm a bot, please talk to me!")
    print(update)

from telegram.ext import CommandHandler
start_handler = CommandHandler('start', start)
dispatcher.add_handler(start_handler)
updater.start_polling()
