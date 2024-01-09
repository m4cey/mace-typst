#let colors(colorscheme: (), doc) = {
	let colors = colorscheme
	if colorscheme.len() == 0 {
		import "./colorschemes/default.typ" as colorscheme
		colors = colorscheme
	}
	set page(
		fill: colors.background
	)
	set text(
		fill: colors.foreground
	)
	doc
}

// TESTS
#show: doc => colors(doc)
#set text(size: 2em)
#let sep() = [#align(center)[#line(length: 50%)]]

= Heading 1
== Heading 2
=== Heading 3
==== Heading 4
===== Heading 5

#sep()

*Bold* _Italic_ *_BoldItalic_*

#sep()

`inline rawtext`

```bash
#!/bin/bash
echo "codeblock\n"
```
#sep()

#table(inset: 0.5em, columns:2, [just],[a],[normal],[table])

#sep()

a quote:
#quote(block: true, attribution: [me])[thou suck ass]

#sep()

Here's some math: $1 + 1 = 3$
$
1 + 1 &= 1 + 0 dots.c 0 + 1 \ &= "what do I fucking know"
$
