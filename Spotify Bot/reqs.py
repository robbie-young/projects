'''
reqs.py
Implements methods to call certain Spotify API endpoints
Written by Robbie Young
'''

import requests
import json
from urllib.parse import quote, urlencode
from base64 import b64encode
from config import access_token



# TODO implement with urllib.parse



'''
AUTHORIZATION REQUESTS/HELPERS
'''

# Helper method to help create the authorization url used in the OAuth2 authentification
# https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
def generate_auth_url(client_id, redirect_uri, scopes, state):
    params = {
        "client_id" : client_id,
        "response_type" : "code",
        "redirect_uri" : redirect_uri,
        "state" : state,
        "scope" : scopes
    }
    return "https://accounts.spotify.com/authorize?" + urlencode(params)

# Gets access token
# https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
def get_access_token(client_id, client_secret, redirect_uri, code):
    auth = b64encode(f"{client_id}:{client_secret}".encode()).decode()
    headers = {
        "Authorization" : "Basic " + auth
    }
    data = {
        "code" : code,
        "redirect_uri" : redirect_uri,
        "grant_type" : "authorization_code"
    }
    url = "https://accounts.spotify.com/api/token"
    response = requests.post(url = url, data = data, headers = headers)
    if response.status_code != 200:
        raise Exception("Failed to get access token")
    return response.json()["access_token"]

"""
GENERAL REQUESTS
"""

# Get Current User's Profile
# https://developer.spotify.com/console/get-current-user/
def me():
    url = "https://api.spotify.com/v1/me"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response

# Search
# https://developer.spotify.com/documentation/web-api/reference/#/operations/search
# filter = album, artist, track, year, upc, tag:{some tag such as new, hipster}, isrc, and genre
# query_type = album, artist, playlist, track, show, episode, audiobook // can be formatted with multiple, such as "album,artist" (unsure how it works with filter)
# if include_external is set to 0 it returns results from external sources, such as YouTube
def search(query, filter = '', query_type = "album,artist,track", include_external = "audio", market = "us", limit = "50"):
    url = f"https://api.spotify.com/v1/search?q={quote(query)}"
    if filter:
        url += f"filter={filter}"
    if query_type:
        url += f"&type={query_type}"
    if include_external:
        url += f"&include_external={include_external}"
    if market:
        url += f"&market={market}"
    if limit:
        url += f"&limit={limit}"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }

    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response



"""
TRACKS/ALBUMS REQUESTS
"""

# Get An Album Tracks
# https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-albums-tracks
def get_album_tracks(album_id):
    url = f"https://api.spotify.com/v1/albums/{album_id}/tracks"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response



"""
PLAYLIST REQUESTS
"""

# Create Playlist
# https://developer.spotify.com/documentation/web-api/reference/#/operations/create-playlist
def create_playlist(name, user_id, description = ""):
    url = f"https://api.spotify.com/v1/users/{user_id}/playlists"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    data = {
        "name" : name,
        "description" : description,
        "public" : True
    }

    response = requests.post(url = url, headers = headers, data = json.dumps(data))
    if response.status_code != 201:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response

# Get a playlist owned by a Spotify user
# https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlist
def get_playlist(playlist_id):
    url = f"https://api.spotify.com/v1/playlists/{playlist_id}"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }

    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response

# Add Items to Playlist
# https://developer.spotify.com/documentation/web-api/reference/#/operations/add-tracks-to-playlist
def add_to_playlist(playlist_id, tracks = []):
    url = f"https://api.spotify.com/v1/playlists/{playlist_id}/tracks"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    data = {
        "uris" : tracks,
        "position" : 0
    }

    response = requests.post(url = url, headers = headers, data = json.dumps(data))
    if response.status_code != 201:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response

# Update Playlist Items
# https://developer.spotify.com/documentation/web-api/reference/#/operations/reorder-or-replace-playlists-tracks
# TODO NOT TESTED
def update_playlist(playlist_id, tracks = [], range_start = '0', insert_before = '0', range_length = '0'):
    url = f"https://api.spotify.com/v1/playlists/{playlist_id}/tracks"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    data = {
        "range_start": range_start,
        "insert_before": insert_before,
        "range_length": range_length
    }
    if tracks:
        data["uris"] = tracks

    response = requests.put(url = url, headers = headers, json = json.dumps(data))

# Get User's Playlists
# https://developer.spotify.com/documentation/web-api/reference/#/operations/get-list-users-playlists
def get_users_playlists(user_id):
    url = f"https://api.spotify.com/v1/users/{user_id}/playlists"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response



"""
ARTIST REQUESTS
"""

# Get Artist's Albums (labeled as albums, but can also be filtered for e.x. singles)
# https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-artists-albums
# TODO make it so that it goes to number 51, then 101 etc until there are none left
def get_artist_songs(artist_id, include_groups = "album,single,appears_on"):
    url = f"https://api.spotify.com/v1/artists/{artist_id}/albums?"
    url += f"&include_groups={include_groups}"
    url += "&limit=50"
    headers = {
        "Authorization" : f"Bearer {access_token}",
        "Content-Type" : "application/json"
    }
    response = requests.get(url = url, headers = headers)
    if response.status_code != 200:
        raise Exception(f"Request error: {response.status_code} {response.text}")
    return response