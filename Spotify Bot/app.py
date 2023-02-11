'''
app.py
Webapp that implements OAuth2 authentication with Spotify's API which returns an access token for a given user (once permission has been granted)
Written by Robbie Young
'''

# TODO implement with environment variables

from flask import Flask, redirect, session, request
from random import SystemRandom
from random import SystemRandom
from config import client_id, client_secret, scopes
import reqs

app = Flask(__name__)
app.secret_key = str(SystemRandom().getrandbits(64))
redirect_uri = "http://localhost:8000/callback"

@app.route("/login")
def login():
    csrf_token = str (SystemRandom().getrandbits(64))
    session["auth"] = reqs.generate_auth_url(client_id = client_id, redirect_uri = redirect_uri, scopes = scopes, state = csrf_token)
    return redirect(session["auth"])

@app.route("/callback")
def callback():
    state = request.args.get("state") or None
    if state is None:
        return "State error"

    code = request.args.get("code") or None
    if code is None:
        return "Code error"

    session["access_token"] = reqs.get_access_token(client_id = client_id, client_secret = client_secret, redirect_uri = redirect_uri, code = code)
    return session["access_token"]

def main():
    app.run(debug = True, port = 8000)

if __name__ == "__main__":
    main()