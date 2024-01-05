#import "@preview/tablex:0.0.7": *
// General Tablex style
#let mytablex(..args) = tablex(inset: 0.6em, ..args)
// Logic Tables
#let truth_table(..args) = mytablex(auto-lines: false, align: center, hlinex(y:1), ..args)
#let pc_table(..args) = {
	let named_args = args.named()
	let columns_len = if type(named_args.columns) == "array" {named_args.columns.len()} else {named_args.columns}
	let variables = columns_len - named_args.premises - named_args.conclusions
	tablex(
		auto-lines: false, align: center, inset: 0.6em,
		..(if variables > 0 {(colspanx(variables)[], vlinex())}),
		colspanx(named_args.premises)[#text(size: 1.3em)[*Premises*]],vlinex(),
		colspanx(named_args.conclusions)[#text(size: 1.3em)[*Conclusions*]],
		hlinex(y:2),
		map-rows: (row, cells) => {
			let arg_cells = cells.filter(c =>
				if c == none {
					false
				} else {
					c.x > variables - 1 and c.y > 1
				}
			)
			let premises_truthness = arg_cells.filter(c => c.x <= variables + named_args.premises - 1)
				.all(c => c.content == [T])
			let conclusions_truthness = arg_cells.filter(c => c.x > variables + named_args.premises - 1)
				.all(c => c.content == [T])
			cells.map(c =>
				if c == none {
					none
				} else {
					let truth_color = if row > 1 and premises_truthness {
						if conclusions_truthness {olive} else {red}
					}
					(..c, fill: truth_color)
				}
			)
		},
		..args
	)
}


// TESTS
#[
#show heading.where(level: 1): it => [
	#let str = it.body.fields().children.fold("#", (a, i) => a + i.text )
	#raw(lang: "typ", str + ":" )]

= truth_table()
#truth_table(
	columns: 4,
	$P$, $not Q$, $P or not Q$, $not(P or not Q)$,
	[F], [T], [T], [F],
	[F], [F], [F], [T],
	[T], [T], [T], [F],
	[T], [F], [T], [F],
)
= pc_table(premises, conclusions)
#pc_table(
	premises: 2, conclusions: 1,
	columns: 5,
	$S$, $L$, $(not S and L) or S$, $S$, $not L$,
	[F], [F], [F], [F], [T],
	[F], [T], [T], [F], [F],
	[T], [F], [T], [T], [T],
	[T], [T], [T], [T], [F],
)
#pc_table(
	premises: 2, conclusions: 2,
	columns: (1fr,1fr,1fr,1fr),
	$A$, $B$, $C$, $D$,
	[T], [T], [F], [T],
	[F], [T], [T], [F],
	[T], [F], [T], [T],
	[T], [T], [T], [T],
)
]
