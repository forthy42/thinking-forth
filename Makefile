SOURCES = thinking-forth.tex \
	chapter3.tex \
	epilog.tex appendixa.tex appendixb.tex appendixc.tex \
	appendixd.tex appendixe.tex \
	tf.sty lstforth.sty lstlocal.cfg \
	fig7-7.tex fig7-8.tex fig7-9.tex

PDFGEN = fig7-7.pdf fig7-8.pdf fig7-9.pdf
EPSGEN = fig7-7.eps fig7-8.eps fig7-9.eps

pdf thinking-forth.pdf : $(SOURCES) $(PDFGEN)
	pdflatex thinking-forth.tex
	pdflatex thinking-forth.tex

ps thinking-forth.ps : thinking-forth.dvi $(EPSGEN)
	dvips $< -o $@

dvi thinking-forth.dvi : $(SOURCES)
	latex thinking-forth.tex
	latex thinking-forth.tex

fig%.pdf fig%.eps:	fig%.tex
	./tex2pdf $<

view : thinking-forth.dvi
	xdvi -paper 6.8125x9.125in thinking-forth.dvi
