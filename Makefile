# Makefile for Thinking Forth

SOURCES = thinking-forth.tex \
	chapter1.tex \
	chapter2.tex \
	chapter3.tex \
	chapter4.tex \
	chapter5.tex \
	chapter6.tex \
	chapter7.tex \
	chapter8.tex \
	epilog.tex appendixa.tex appendixb.tex appendixc.tex \
	appendixd.tex appendixe.tex \
	tf.sty lstforth.sty lstlocal.cfg \
	fig1-1.tex fig1-3.tex fig1-4.tex fig1-6.tex \
	fig7-7.tex fig7-8.tex fig7-9.tex

PNGSOURCES = \
	fig1-1.png fig1-2.png fig1-3.png fig1-4.png fig1-5.png fig1-6.png \
	fig1-7.png fig1-8.png fig1-9.png fig1-10.png \
	fig2-1.png fig2-2.png fig2-3.png fig2-4.png fig2-5.png fig2-6.png \
	fig2-7.png fig2-8.png \
	fig3-1.png fig3-2.png fig3-3.png fig3-4.png fig3-5.png fig3-6.png \
	fig3-7.png fig3-8.png fig3-9.png fig3-10.png \
	fig4-1.png fig4-2.png fig4-3.png fig4-4.png fig4-5.png fig4-6.png \
	fig4-7.png fig4-8.png \
	fig5-1.png fig5-2.png \
	fig7-1.png fig7-3.png fig7-5.png \
	fig8-6.png img1-004.png img1-010.png img1-013.png img1-028.png \
	img1-030.png img1-033.png \
	img2-047.png img2-060.png img2-063.png img2-066.png \
	img4-103.png img4-106.png img4-110.png img7-211.png \
	no-scrambled.png

all:	pspdf ps

pspdf:	thinking-forth.pdf

thinking-forth.pdf : thinking-forth.ps
	ps2pdf thinking-forth.ps thinking-forth.pdf

pdf : $(SOURCES) $(PNGSOURCES:.png=.pdf)
	pdflatex thinking-forth.tex
	pdflatex thinking-forth.tex

ps :	thinking-forth.ps

thinking-forth.ps : thinking-forth.dvi
	dvips $< -o $@

dvi thinking-forth.dvi : $(SOURCES) $(PNGSOURCES:.png=.eps)
	latex thinking-forth.tex
	latex thinking-forth.tex

#fig%.pdf fig%.eps:	fig%.tex
#	./tex2pdf $<
#
#inl%.pdf inl%.eps:	inl%.tex
#	./tex2pdf $<

img%.pdf:	img%.eps
	./eps2pdf $<

fig%.pdf:	fig%.eps
	./eps2pdf $<

AUTOTRACE = autotrace --despeckle-level 8 --error-threshold 4

fig%.eps:	fig%.png
	$(AUTOTRACE) $< >$@
	./autoscale $@

img%.eps:	img%.png
	$(AUTOTRACE) $< >$@
	./autoscale $@

no-scramble.eps:	no-scramble.png
	$(AUTOTRACE) $< >$@
	./autoscale $@

no-scramble.pdf:	no-scramble.eps
	./eps2pdf $<

view : thinking-forth.dvi
	xdvi -paper 6.8125x9.125in thinking-forth.dvi
