#import "@preview/tablex:0.0.7": *
// General Tablex style
#let mytablex(..args) = tablex(inset: 0.6em, ..args)
// Logic Tables
#let truth_table(..args) = mytablex(auto-lines: false, align: center, hlinex(y:1), ..args)
#let pc_table(..args) = {
	let named_args = args.named()
	let variables = named_args.columns.len() - named_args.premises - named_args.conclusions
	tablex(
		auto-lines: false, align: center, inset: 0.6em,
		..(if variables > 0 {(colspanx(variables)[], vlinex())}),
		colspanx(named_args.premises)[*Premises*],vlinex(),
		colspanx(named_args.conclusions)[#text(size: 1.3em)[*Conclusions*]],
		hlinex(y:2),
		..args
	)
}


// TESTS
#[
#show heading.where(level: 1): it => [
	#let str = it.body.fields().children.fold("#", (a, i) => a + i.text )
	#raw(lang: "typ", str + ":" )]

= truth_table
#truth_table(
	columns: 4,
	$P$, $not Q$, $P or not Q$, $not(P or not Q)$,
	[F], [T], [T], [F],
	[F], [F], [F], [T],
	[T], [T], [T], [F],
	[T], [F], [T], [F],
)
= pc_table
#pc_table(
	premises: 2, conclusions: 1,
	columns: (auto,auto, 3fr, 1fr, 2fr),
	$S$, $L$, $(not S and L) or S$, $S$, $not L$,
	[F], [F], [F], [F], [T],
	[F], [T], [T], [F], [F],
	[T], [F], [T], [T], [T],
	[T], [T], [T], [T], [F],
	map-rows: (row, cells) => cells.map(c =>
		if c == none {
			c
		} else {
			(..c, fill: if row == 4 { color.gray } else if row == 5 { color.red })
		}
	),
)
]
