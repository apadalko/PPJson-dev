#!flask/bin/python
# coding : utf-8
from flask import Flask, request, make_response, render_template
app = Flask(__name__)
app.debug = True
app = Flask(__name__, template_folder='.', static_url_path='/')
app.debug = True
app.secret_key = 'dsaASDSdasdaADSASDasadasddasGH'
@app.route('/map')
def user_data():
    return make_response(render_template('PPMap.html'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8989)



