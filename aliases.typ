#let space_around(vertical: false, outer: 3fr, inner: 1fr, sep:",", ..args) = {
	let space(vertical, size) = if vertical {v(size)} else {h(size)}
	[
		#space(vertical, outer)
		#for (i, arg) in args.pos().enumerate() {
			if i > 0 and i < args.pos().len() { space(vertical, inner) }
			arg + sep
		}
		#space(vertical, outer)
	]
}

// TESTS
#[
#show heading.where(level: 1): it => [
	#let str = it.body.fields().children.fold("#", (a, i) => a + i.text )
	#raw(lang: "typ", str + ":" )]
= space_around(outer:3fr,inner:1fr,sep:\",\",args)

#space_around(
outer: 2fr,
inner: 1fr,
sep: ",",
$not(P and Q)$,
$not P and not Q$,
$not P or not Q$,
)

]
