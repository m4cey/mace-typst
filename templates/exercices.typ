#let template(doc) = [
	#set page(
	paper: "a4",
	margin: (x: 1.8cm, y: 1.5cm),
	numbering: "1"
	)
	#set text(
	font: "Noto Sans",
	size: 12pt,
	)
	#show math.equation: set text(
	font: "Noto Sans Math",
	size: 1em,
	)
	#set par(
	justify:true,
	leading: 0.6em,
	)
	#show heading: it => [
		#set align(start)
		#counter(heading).display()
		#smallcaps(it.body)
	]
	#set heading(numbering: "I.1.1.")
	// hide numbering of the first n levels
	/*
	#let n = 1
	#set heading(numbering:
		(..nums) => nums.pos().filter(level => level > n).map(str).join("."))
	// hide numbering on the first heading
	#show heading.where(level: 1): it => [
		#set align(start)
		#smallcaps(it.body)
	]

	// layout heading numbers in front
	#show outline.entry: it => {
		link(it.element.location(),
		{
			it.element.body + " "
			if (it.level > 1) {
				numbering("1.1", ..counter(heading).at(it.element.location()))
			}
			box(width:1fr,it.fill)
			it.page
		})
	}
	*/
	#show outline.entry.where(
	  level: 1
	): it => {
	  v(12pt, weak: false)
	  strong(it)
	}
	#doc
]
#let title(body) = {
	align(center + horizon)[
		#text(size: 2em)[#strong(delta: 1000,body)]
	]
	line(start: (0%,0%), length: 100%)
}

#let answer(hide: false, body) = [
	#{
	//is content body empty?
	let fields = body.fields()
	let hascontent = fields.at("children", default: false)
	if type(hascontent) == "boolean" {
		hascontent = fields.at("text", default: false)
		hascontent = type(hascontent) == "string"
	} else {
		hascontent = hascontent.len() > 1
	}

	if not hide and hascontent [
		#align(center)[#pad(x: 1em, bottom:1em)[#rect(inset: 0.8em)[
		#align(left)[#body]
	]]]]
	}
]
