// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.addEventListener("turbolinks:load", () => {
	if(window.location.href.match(/\/elections\/\d+\/live/))
		setInterval(() => {
			window.location.reload(true)
		}, 10000)
})
