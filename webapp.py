#!flask/bin/python
import os
from helpers import filemanager
import json
from flask import Flask, render_template, request, make_response, redirect, url_for
import subprocess
from werkzeug.serving import make_ssl_devcert

#make_ssl_devcert('./cert', host='0.0.0.0')


#
#context = ('cert.crt', 'cert.key')



if os.environ.get('GM_PRODUCTION_SERVER'):
    api_key = '&key=AIzaSyCQT5ujgQ4LElR6Vopz_E7gC29gFFlOPXc'
else:
    api_key = ''


app = Flask(__name__, template_folder='web', static_folder='web/static')
app.debug = True

app.secret_key = 'aDADSADADdad289eyhdaskhdash12edkja'





@app.route('/')
def main_screen():
    return render_template('index.html', data={'api_key': api_key})

# @app.route('/pull')
# def git_pull():
#     subprocess.call(['git', 'fetch', 'origin', 'master'])
#     subprocess.call(['git', 'reset', '--hard', 'FETCH_HEAD'])
#     subprocess.call(['git', 'clean', '-df'])
#     subprocess.call(['git', 'pull'])

@app.route('/apple-app-site-association')
def apple_file():
    return render_template('apple-app-site-association')





#/controllers?type = 222
#api
@app.route('/controllers',methods = ['GET'])
def get_controllers():
    type = request.values["type"]
    if type == "core":
        result = filemanager.get_folder_list('/PPJFiles/PPJCore/controllers/')
        return make_response(json.dumps(result), 200)
    else:
        return 'bad type'

if __name__ == '__main__':
#    context = ('cert.crt', 'cert.key')
    app.run(host='0.0.0.0', port=8080)