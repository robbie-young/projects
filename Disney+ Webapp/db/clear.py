'''
    convert.py
    Authors: Kevin Bui, Robbie Young, November 11 2021
    A program designed to clear all created csv files after running convert.py
    For use in the final project in Carleton College's CS 257 Software Design Class, Fall 2021
    Credits: https://stackoverflow.com/questions/10840533/most-pythonic-way-to-delete-a-file-which-may-not-exist
'''

import os

def clear(filename):
    try:
        os.remove(filename)
    except OSError:
        pass

def main():
    clear('type.csv')
    clear('countries.csv')
    clear('date_added.csv')
    clear('rating.csv')
    clear('genres.csv')
    clear('super_table.csv')
    
    print("clear.py done")

if __name__ == '__main__':
    main()