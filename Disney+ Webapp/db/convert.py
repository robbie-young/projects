'''
    convert.pty
    Authors: Kevin Bui, Robbie Young
    A program designed to read and convert a single csv file to a structured organization
    For use in the final project in Carleton College's CS 257 Software Design Class, Fall 2021
'''

import csv

type_dict = {} # {'type' : id}
countries_dict = {} # {'countries' : id}
date_added_dict = {} # {'date_added' : id}
rating_dict = {} # {'rating' : id}
genres_dict = {} # {'genres' : id}
super_table_dict = {} # {'type_id|title|director|actors|countries_id|date_added|release_year|rating_id|duration|genre_id|description' : id}

# either clears the csv file if already existing or creates a new file
def create_files():
    with open('type.csv', 'w') as file:
        file.truncate()
    with open('countries.csv', 'w') as file:
        file.truncate()
    with open ('date_added.csv', 'w') as file:
        file.truncate()
    with open('rating.csv', 'w') as file:
        file.truncate()
    with open('genres.csv', 'w') as file:
        file.truncate()
    with open('super_table.csv', 'w') as file:
        file.truncate()

# loads the dictionaries
def load(csv_file_name):
    with open(csv_file_name, 'r', newline='') as file:
        next(file)
        reader = csv.reader(file)
        for row in reader: # [0] show_id, [1] type, [2] title, [3] director, [4] cast, [5] country, [6] date_added, [7] release_year, [8] rating, [9] duration, [10] listed_in, [11] description
            this_type_id = populate_type(type_var=row[1])
            this_countries_id = populate_countries(countries=row[5])
            this_date_added_id = populate_date_added(date_added=row[6])
            this_rating_id = populate_rating(rating=row[8])
            this_genres_id = populate_genres(genres=row[10])
            populate_super_table(type_id=this_type_id, title=row[2], director=row[3], cast=row[4], countries_id=this_countries_id, date_added_id=this_date_added_id, release_year=row[7], rating_id=this_rating_id, duration=row[9], genres_id=this_genres_id, description=row[11])
    
    # following writes to the new csv files with the now loaded and formatted data
    write_to('type.csv', type_dict)
    write_to('countries.csv', countries_dict)
    write_to('date_added.csv', date_added_dict)
    write_to('rating.csv', rating_dict)
    write_to('genres.csv', genres_dict)
    write_to('super_table.csv', super_table_dict)

# all populate methods, except for populate_super_table check for duplicates (and if so returns id number), and if not creates new key value pair and returns new id number
def populate_type(type_var):
    if type_var in type_dict:
        return type_dict[type_var]
    
    id = len(type_dict) + 1
    type_dict[type_var] = id
    return id

def populate_countries(countries):
    if countries in countries_dict:
        return countries_dict[countries]
    
    id = len(countries_dict) + 1
    countries_dict[countries] = id
    return id

def populate_date_added(date_added):
    if date_added in date_added_dict:
        return date_added_dict[date_added]
    
    id = len(date_added_dict) + 1
    date_added_dict[date_added] = id
    return id

def populate_rating(rating):
    if rating in rating_dict:
        return rating_dict[rating]
    
    id = len(rating_dict) + 1
    rating_dict[rating] = id
    return id

def populate_genres(genres):
    if genres in genres_dict:
        return genres_dict[genres]
    
    id = len(genres_dict) + 1
    genres_dict[genres] = id
    return id

# creates new key value pair of each entry; note there can be duplicates
def populate_super_table(type_id, title, director, cast, countries_id, date_added_id, release_year, rating_id, duration, genres_id, description):
    data = str(type_id)+'|'+title+'|'+director+'|'+cast+'|'+str(countries_id)+'|'+str(date_added_id)+'|'+release_year+'|'+str(rating_id)+'|'+duration+'|'+str(genres_id)+'|'+description
    id = len(super_table_dict) + 1
    super_table_dict[data] = str(id)

# writes to csv file with the data stored in the dictionary
def write_to(file, dictionary):
    with open(file, 'a', newline='') as file:
        writer = csv.writer(file)
        for read_data in dictionary:
            write_data = read_data.split('|')
            write_data.insert(0, str(dictionary[read_data]))
            writer.writerow(write_data)

def main():
    create_files()
    load('disney_plus_titles.csv')
    print('convert.py done')

if __name__ == '__main__':
    main()