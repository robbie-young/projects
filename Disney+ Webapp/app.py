'''
app.py 
Thien K. M. Bui, Robbie Young 
Updated 11 November, 2021

Flask application to serve disneyplus data from api.py
For use in Carleton CS 251 Fall 2021
'''


import sys
import flask
import api

app = flask.Flask(__name__, static_folder='static',
                  template_folder='templates')
app.register_blueprint(api.api, url_prefix='/api')


@app.route('/')
def get_main_page():
    return flask.render_template('index.html')


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: {0} host port'.format(sys.argv[0]), file=sys.stderr)
        exit()

    host = sys.argv[1]
    port = int(sys.argv[2])
    app.run(host=host, port=port, debug=True)
