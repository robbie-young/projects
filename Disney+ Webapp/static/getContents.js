/*getContents.js 
Thien K. M. Bui and Robbie Young 08 November 2021
Updated 23 November 2021


Helper methods to fetch data from our api.py
For use in Carleton CS 251 Fall 2021
*/

const getAPIBaseUrl = () => {
	const baseUrl = `${window.location.protocol}//${window.location.hostname}:${window.location.port}/api`;
	return baseUrl;
};

//store searched results in localStorage to be used later
const storeConentsInLocalStorage = (contents) => {
	window.localStorage.setItem("searched-results", contents);
};

const getRecommended = () => {
	const genre = document.getElementById("genre-select");
	const genreString = genre.value;
	const url = `${getAPIBaseUrl()}/recommended?genres=${genreString}`;
	// send GET request to specified URL
	fetch(url, { method: "GET" })
		.then((response) => response.json())
		.then((jsonResponse) => {
			let contentHTML = "";
			//internal agreement, API will ONLY ever return 1 object in a list of size 1
			const content = jsonResponse[0];
			contentHTML = `
                <div class="content-container">
                    <div class="content">
                        <div class="content-title">
                            <strong>${content.title}</strong>
							(${content.type})
                        </div>
                        <div class="content-subheading">
                            <strong>Director(s):</strong> ${content.directors}
                        </div>
                        <div class="content-subheading">
                            <strong>Cast(s):</strong> ${content.cast}
                        </div>
						<div class="content-subheading">
							<strong>Genre(s):</strong> ${content.genres}
						</div>
                        <div class="content-sypnopsis">
                            <strong>Sypnopsis:</strong>
                            ${content.description}
                        </div>
                    </div>
                </div> 
            `;
			const recommendedContainer = document.getElementById(
				"recommended-contents"
			);
			recommendedContainer.innerHTML = contentHTML;
		});
};

//------------------------- by title handler

const getByTitle = (titleString) => {
	const url = getAPIBaseUrl() + `/titles/${titleString}`;
	// send GET request to specified URL
	fetch(url, { method: "GET" })
		.then((response) => response.json())
		.then((jsonContent) => {
			const noResultElement = document.getElementById("no-result-found");
			const contentsContainer = document.getElementById("contents-container");

			if (jsonContent.length === 0) {
				noResultElement.style.display = "flex";
				contentsContainer.style.display = "none";
			} else {
				noResultElement.style.display = "none";
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

				const showsTag = document.getElementById("show-tag");
				const moviesTag = document.getElementById("movies-tag");
				if (formattedShows) {
					showsTag.style.display = "block";
					tvShowsContainer.style.display = "flex";
				} else {
					showsTag.style.display = "none";
					tvShowsContainer.style.display = "none";
				}
				if (formattedMovies) {
					moviesTag.style.display = "block";
					moviesContainer.style.display = "flex";
				} else {
					moviesTag.style.display = "none";
					moviesContainer.style.display = "none";
				}
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;

				contentsContainer.style.display = "flex";
				storeConentsInLocalStorage(JSON.stringify(jsonContent));
			}
		});
};

//------------------------- by directors

const getByDirector = (directorString) => {
	const url = getAPIBaseUrl() + `/directors/${directorString}`;
	// send GET request to specified URL
	fetch(url, { method: "GET" })
		.then((response) => response.json())
		.then((jsonContent) => {
			const noResultElement = document.getElementById("no-result-found");
			const contentsContainer = document.getElementById("contents-container");

			if (jsonContent.length === 0) {
				noResultElement.style.display = "flex";
				contentsContainer.style.display = "none";
			} else {
				noResultElement.style.display = "none";
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

				const showsTag = document.getElementById("show-tag");
				const moviesTag = document.getElementById("movies-tag");
				if (formattedShows) {
					showsTag.style.display = "block";
					tvShowsContainer.style.display = "flex";
				} else {
					showsTag.style.display = "none";
					tvShowsContainer.style.display = "none";
				}
				if (formattedMovies) {
					moviesTag.style.display = "block";
					moviesContainer.style.display = "flex";
				} else {
					moviesTag.style.display = "none";
					moviesContainer.style.display = "none";
				}
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;

				contentsContainer.style.display = "flex";
				storeConentsInLocalStorage(JSON.stringify(jsonContent));
			}
		});
};

//------------------------ by cast
const getByCast = (castString) => {
	const url = getAPIBaseUrl() + `/cast/${castString}`;
	// send GET request to specified URL
	fetch(url, { method: "GET" })
		.then((response) => response.json())
		.then((jsonContent) => {
			const noResultElement = document.getElementById("no-result-found");
			const contentsContainer = document.getElementById("contents-container");

			if (jsonContent.length === 0) {
				noResultElement.style.display = "flex";
				contentsContainer.style.display = "none";
			} else {
				noResultElement.style.display = "none";
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

				const showsTag = document.getElementById("show-tag");
				const moviesTag = document.getElementById("movies-tag");
				if (formattedShows) {
					showsTag.style.display = "block";
					tvShowsContainer.style.display = "flex";
				} else {
					showsTag.style.display = "none";
					tvShowsContainer.style.display = "none";
				}
				if (formattedMovies) {
					moviesTag.style.display = "block";
					moviesContainer.style.display = "flex";
				} else {
					moviesTag.style.display = "none";
					moviesContainer.style.display = "none";
				}
				tvShowsContainer.innerHTML = formattedShows;
				moviesContainer.innerHTML = formattedMovies;

				contentsContainer.style.display = "flex";
				storeConentsInLocalStorage(JSON.stringify(jsonContent));
			}
		});
};

//on window load, recommend a random content
window.onload = getRecommended;
