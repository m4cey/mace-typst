#import "@preview/tablex:0.0.7": *
// General Tablex style
#let mytablex(..args) = tablex(auto-lines: false, align: center, inset: 0.6em, ..args)
// Logic Tables
#let truth_table(..args) = mytablex(hlinex(y:1))
#let pc_table(..args) = tablex(auto-lines: false, hlinex(y:1), align: center, inset: 0.6em, ..args)


// TESTS
#truth_table(
columns: 3,
[1], [2], [3],
[4], [5], [6],
[7], [8], [9],
cellx(colspan:3, align: center)[0]
)
#truth_table(
		columns: (auto,auto, 3fr, 1fr, 2fr),
		[], [], vlinex(), colspanx(2)[Premises],vlinex(),  [Conclusion],
		$S$, $L$, $(not S and L) or S$, $S$, $not L$,
		hlinex(),
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
