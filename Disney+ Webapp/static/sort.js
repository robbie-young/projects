/* sort.js 
 Written by Thien K. M. Bui and Robbie Young 
 Last updated Nov 23 2021 

 Simple sorting from localStorage
*/

const initSortBy = () => {
	const sortBySelect = document.getElementById("sort-by-select");
	sortBySelect.onchange = sort;
};

//use built in Array.sort() method to sort a list retrieved from localStorage
//after sorting, the sort function will change DOM to reflect the new sorted order
const sort = () => {
	const sortBySelect = document.getElementById("sort-by-select");
	const sortBy = sortBySelect.value;
	switch (sortBy) {
		case "title":
			if (window.localStorage.getItem("searched-results")) {
				const jsonStorage = JSON.parse(
					window.localStorage.getItem("searched-results")
				);
				const jsonContent = jsonStorage.sort((a, b) => {
					if (a.title < b.title) {
						return -1;
					} else {
						return 1;
					}
				});
				let formattedShows = "";
				let formattedMovies = "";
				jsonContent.forEach((content) => {
					if (content.type === "Movie") {
						formattedMovies = formattedMovies + formatIntoHTML(content);
					} else if (content.type === "TV Show") {
						formattedShows = formattedShows + formatIntoHTML(content);
					}
				});
				const tvShowsContainer = document.getElementById("tvshows-container");
				const moviesContainer = document.getElementById("movies-container");
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;
			}
			break;
		case "release_year":
			if (window.localStorage.getItem("searched-results")) {
				const jsonStorage = JSON.parse(
					window.localStorage.getItem("searched-results")
				);
				const jsonContent = jsonStorage.sort((a, b) => {
					if (a.release_year < b.release_year) {
						return -1;
					} else {
						return 1;
					}
				});
				let formattedShows = "";
				let formattedMovies = "";
				jsonContent.forEach((content) => {
					if (content.type === "Movie") {
						formattedMovies = formattedMovies + formatIntoHTML(content);
					} else if (content.type === "TV Show") {
						formattedShows = formattedShows + formatIntoHTML(content);
					}
				});
				const tvShowsContainer = document.getElementById("tvshows-container");
				const moviesContainer = document.getElementById("movies-container");
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;
			}
			break;
		case "duration":
			if (window.localStorage.getItem("searched-results")) {
				const jsonContent = JSON.parse(
					window.localStorage.getItem("searched-results")
				);

				let movies = [];
				let shows = [];
				jsonContent.forEach((content) => {
					if (content.type === "Movie") {
						movies = [...movies, content];
					} else if (content.type === "TV Show") {
						shows = [...shows, content];
					}
				});
				//sort by duration, need to typecast into Number since durations are stored as strings
				movies.sort((a, b) => {
					if (Number(a.duration.min) < Number(b.duration.min)) {
						return -1;
					} else {
						return 1;
					}
				});
				shows.sort((a, b) => {
					if (Number(a.duration.seasons) < Number(b.duration.seasons)) {
						return -1;
					} else {
						return 1;
					}
				});

				let formattedShows = "";
				let formattedMovies = "";

				movies.forEach(
					(content) =>
						(formattedMovies = formattedMovies + formatIntoHTML(content))
				);
				shows.forEach(
					(content) =>
						(formattedShows = formattedShows + formatIntoHTML(content))
				);

				const tvShowsContainer = document.getElementById("tvshows-container");
				const moviesContainer = document.getElementById("movies-container");
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;
			}
			break;
		default:
			window.alert("something went wrong, please refresh the page");
	}
};

window.addEventListener("load", initSortBy, true);
