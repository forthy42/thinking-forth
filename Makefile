SOURCES = thinking-forth.tex \
	chapter3.tex \
	epilog.tex appendixa.tex appendixb.tex appendixc.tex \
	appendixd.tex appendixe.tex

thinking-forth.ps : thinking-forth.dvi
	dvips $^ -o $@

thinking-forth.dvi : $(SOURCES)
	latex thinking-forth.tex
	latex thinking-forth.tex

