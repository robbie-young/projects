/*
    htmlHelper.js
    Written by Thien K. M. Bui, Robbie Young 
    Last updated 15 November 2021

    HTML template to be used for javascript innerHTML
*/

const formatIntoHTML = (content) => {
	const duration = content.duration.min
		? `${content.duration.min} min`
		: `${content.duration.seasons} season`;
	return `
        <div class="content-container">
            <div class="content">
                <div class="content-title">
                    <strong>${content.title}</strong>
                    (${content.release_year})
                </div>
                <div class="content-subheading">
                    <strong>Director(s):</strong> ${content.directors}
                </div>
                <div class="content-subheading">
                    <strong>Cast(s):</strong> ${content.cast}
                </div>
                <div class="content-subheading">
                    <strong>Duration:</strong> ${duration}
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
};
