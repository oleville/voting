// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const hooky = () => {
	[].slice.call(document.querySelectorAll('.position')).forEach((position) => {
		let buttons = [].slice.call(position.querySelectorAll('.candidate .selector input'))
		let disabledRanks = []

		let rectify = () => {
			let selectedButtons = buttons.filter(button => button.checked)

			let selectedRanks = selectedButtons.map(button => {
				let rankNumberMatch = button.getAttribute('id').toString().match(/_rank_(\d+)/)

				if(rankNumberMatch)
					return rankNumberMatch[0]
				else
					return null
			}).filter(rank => !!rank)

			selectedRanks.forEach(rank => {
				[].slice.call(position.querySelectorAll(`[id$=${rank}]`)).forEach(element => { element.disabled = true })
				disabledRanks.push(rank)
			})

			let ranksToEnable = disabledRanks
				.filter(disabledRank => selectedRanks.indexOf(disabledRank) < 0)
				.filter((value, index, array) => array.indexOf(value) === index)

			ranksToEnable.forEach(rank => {
				[].slice.call(position.querySelectorAll(`[id$=${rank}]`)).forEach(element => { element.disabled = false })
				disabledRanks = disabledRanks.filter(rankToCheck => rankToCheck !== rank)
			})
		}

		buttons.forEach((input) => {
			input.onchange = rectify
		})
	})
}

window.onload = () => { hooky(); }
