from flask import Flask
import os
import socket

app = Flask(__name__)

@app.route("/")
def hello_wrold():
    html = "<h3>Hello {name}!</h3>" \
           "<font color='{color}'>Version: {version}</font><br/>"\
           "<b>Hostname:</b> {hostname}<br/>"
    return html.format(name=os.getenv("NAME", "World"), 
                       color=os.getenv("COLOR", "red"),
                       version=os.getenv("VERSION", "v0"), 
                       hostname=socket.gethostname())

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)