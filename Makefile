SOURCES = thinking-forth.tex \
	chapter3.tex \
	epilog.tex appendixa.tex appendixb.tex appendixc.tex \
	appendixd.tex appendixe.tex \
	tf.sty lstforth.sty lstlocal.cfg

pdf thinking-forth.pdf : $(SOURCES)
	pdflatex thinking-forth.tex
	pdflatex thinking-forth.tex

ps thinking-forth.ps : thinking-forth.dvi
	dvips $< -o $@

dvi thinking-forth.dvi : $(SOURCES)
	latex thinking-forth.tex
	latex thinking-forth.tex

view : thinking-forth.dvi
	xdvi -paper 6.8125x9.125in thinking-forth.dvi
