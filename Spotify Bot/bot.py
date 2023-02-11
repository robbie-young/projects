'''
bot.py
Custom bot which, when given an artist, creates three seperate playlists (albums, singles, and features), and populates each playlist with the pertinent tracks
Written by Robbie Young
'''

import reqs

user_id = reqs.me().json()["id"]

def get_uris(albums):
    albums_reordered = sorted(albums, key = lambda x : x["release_date"])
    album_ids = [album["id"] for album in albums_reordered]

    all_track_uris = []
    for id in album_ids:
        album_tracks = reqs.get_album_tracks(album_id = id).json()["items"]
        album_track_uris = [track["uri"] for track in album_tracks]
        all_track_uris += album_track_uris
    
    return all_track_uris

def create_artist_playlists(artist):

    artist = reqs.search(query = artist, query_type = "artist", limit = "1").json()["artists"]["items"][0] # searches for given artist and converts into json object and parses through response
    # TODO check to make sure that artist is one wanted
    # TODO add a check for all albums, singles, and allow user to remove specific ones
    artist_id = artist["id"]
    artist_name = artist["name"]
    albums = f"{artist_name}: Albums"
    singles = f"{artist_name}: Singles"
    features = f"{artist_name}: Features"

    # if playlist already exists update that one, overwrite with new songs though
    playlists = reqs.get_users_playlists(user_id = user_id).json()["items"]
    # names of playlists

    print(f"Beginning with {artist_name}")

    # one could also grab the playlists from the get_playlist method in reqs. The difference is this way excludes the "followers" key, and the "tracks" key is less detailed this way. However this is potentially three less calls this way and the above keys are not needed
    for playlist in playlists:
        if playlist["name"] == albums:
            albums_playlist = playlist
        elif playlist["name"] == singles:
            singles_playlist = playlist
        elif playlist["name"] == features:
            features_playlist = playlist
            # features_playlist = reqs.get_playlist(playlist["id"]).json()
    
    if "albums_playlist" not in locals():
        albums_playlist = reqs.create_playlist(name = albums, description = f"List of {artist_name}'s tracks from albums", user_id = user_id).json() # TODO check ordering
    if "singles_playlist" not in locals():
        singles_playlist = reqs.create_playlist(name = singles, description = f"List of {artist_name}'s singles", user_id = user_id).json() # TODO check ordering
    if "features_playlist" not in locals():
        features_playlist = reqs.create_playlist(name = features, description = f"List of tracks where {artist_name} appears on as a feature", user_id = user_id).json() # TODO check ordering
    
    # TODO update to use reqs.update_playlist()
    albums = reqs.get_artist_songs(artist_id = artist_id, include_groups = "album").json()["items"]
    album_uris = get_uris(albums)

    singles = reqs.get_artist_songs(artist_id = artist_id, include_groups = "single").json()["items"]
    single_uris = get_uris(singles)

    features = reqs.get_artist_songs(artist_id = artist_id, include_groups = "appears_on").json()["items"]
    feature_uris = get_uris(features)

    print(f"Beginning with {artist_name}'s albums")
    
    # max number of tracks per request is 100, sends a new request for every 100 tracks
    for i in range(0, len(album_uris), 100):
        reqs.add_to_playlist(playlist_id = albums_playlist["id"], tracks = album_uris[i : i + 100])
    
    print(f"Done with {artist_name}'s albums")
    print(f"Beginning with {artist_name}'s singles")
    
    for i in range(0, len(single_uris), 100):
        reqs.add_to_playlist(playlist_id = singles_playlist["id"], tracks = single_uris[i : i + 100])
    
    print(f"Done with {artist_name}'s singles")
    print(f"Beginning with {artist_name}'s features")
    
    for i in range(0, len(feature_uris), 100):
        reqs.add_to_playlist(playlist_id = features_playlist["id"], tracks = feature_uris[i : i + 100])
    
    print(f"Done with {artist_name}'s features")

    print(f"Finished with {artist_name}")



def main():
    with open("artists.txt", "r") as file:
        for line in file:
            create_artist_playlists(line.strip())

if __name__ == "__main__":
    main()