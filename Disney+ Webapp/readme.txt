AUTHORS: Kevin Bui, Robbie Young, November 23 2021

DATA: Information on current movies and TV shows on Disney+

	For use in the final project in Carleton College's CS 257 Software Design Class, Fall 2021. To get the raw data used in this project, please click on the following link and click download:
	Raw data: https://www.kaggle.com/shivamb/disney-movies-and-tv-shows (Note: an account is required)

STATUS:
	User can search for content (either TV shows or Movies) based on a certain title, director, or cast member. If there is no matching content found, the user will be notified.
	User can sort the results by title, release year, or duration (all in ascending order)
	User is able to see ordered results divided into two categories: TV Shows, and movies
	User is not able to decide whether to see movies or TV shows displayed first
	User can get a random recommendation based on a certain genre (currently supported genres are: Action (Default genre), Comedy, Documentary, Mystery, and Science Fiction)
	User may get a recommendation that has already been displayed; there is no "ignore" movie list which the recommendation button will take into account
	Images associated with the movie or TV show are not implemented, and the results are solely textual

NOTES:
	This data is accurate as of the 1st of October, 2021. Any future additions/removals of content on Disney+ is not currently supported. 
	As long as future data is provided in a CSV file with the following format: 
		
		show_id,type,title,director,cast,country,date_added,release_year,rating,duration,listed_in,description

	any future data updates can be loaded into the database, and therefore updating the website, without error


Copyright © 2021 <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE