// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const hooky = () => {
	[].slice.call(document.querySelectorAll('.position')).forEach((position) => {
		console.log(`Inserting hooks for ${position}`);

		[].slice.call(position.querySelectorAll('.candidate .selector input')).forEach((input) => {
			input.onclick = () => {
				let rankChoice = input.getAttribute('id').toString().match(/_rank_(\d+)/)[0];
				let otherRanksForThisPosition = [].slice.call(position.querySelectorAll(`[id$=${rankChoice}]`)).filter(item => item !== input )

				otherRanksForThisPosition.forEach(element => element.disabled = true)
			}
		})
	})
}

window.onload = () => { hooky(); }
