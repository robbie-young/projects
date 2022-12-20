/*formHandlers.js 
Thien K. M. Bui and Robbie Young 14 November 2021
Updated 15 November 2021


Helper methods to handle event listeners
For use in Carleton CS 251 Fall 2021
*/
const initSearches = () => {
	const searchButton = document.getElementById("search-button");
	searchButton.onclick = handleSearchSelection;
};

const handleSearchSelection = (e) => {
	e.preventDefault();
	const searchBy = document.getElementById("search-by").value;
	const searchString = document.getElementById("search-bar").value;

	if (searchString) {
		switch (searchBy) {
			case "title":
				getByTitle(searchString);
				break;
			case "director":
				getByDirector(searchString);
				break;
			case "cast":
				getByCast(searchString);
				break;
			default:
				window.alert("something went wrong, please refresh the page");
				break;
			// code block
		}
	} else {
		window.alert("search field can not be empty");
	}
};

// Recommend handler
const initGetRecommended = () => {
	const recommendButton = document.getElementById("recommend-button");
	recommendButton.onclick = getRecommended;
};

window.addEventListener("load", initSearches, true);
window.addEventListener("load", initGetRecommended, true);
