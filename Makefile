# Makefile for Thinking Forth

SOURCES = thinking-forth.tex \
	tfoptions.tex \
	bio.tex copyright.tex quotation.tex tocpages.tex title.tex title2.tex \
	preface.tex \
	preface94.tex \
	preface2004.tex \
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
	fig7-7.tex fig7-8.tex fig7-9.tex \
	backpage.tex cover.tex legalcode-by-nc-sa.tex \
	autoscale eps2pdf \
	head.eps leobrodie.jpg leobrodie.eps
#	rodin_thinker.jpg rodin_thinker.eps

ALL_SOURCES = $(SOURCES) Makefile

PNGSOURCES = \
	fig1-1.png fig1-2.png fig1-3.png fig1-5.png \
	fig1-7.png fig1-8.png fig1-9.png fig1-10.png \
	fig2-1.png fig2-2.png fig2-3.png fig2-4.png fig2-5.png fig2-6.png \
	fig2-7.png fig2-8.png \
	fig3-1.png fig3-2.png fig3-3.png fig3-4.png fig3-5.png fig3-6.png \
	fig3-7.png fig3-8.png fig3-9.png fig3-10.png \
	fig4-1.png fig4-2.png fig4-3.png fig4-4.png fig4-5.png fig4-6.png \
	fig4-7.png fig4-8.png \
	fig5-1.png fig5-2.png \
	fig7-1.png fig7-3.png fig7-5.png \
	fig8-6.png \
	img1-004.png img1-010.png img1-013.png img1-028.png \
	img1-030.png img1-033.png \
	img2-047.png img2-060.png img2-063.png img2-066.png \
	img4-103.png img4-106.png img4-110.png img7-211.png \
	no-scrambled.png \
	img-by.png img-nc.png img-sa.png img-cc.png logo_code.png \
	pointing-l.png pointing-r.png

WIDTH = 6.8125in
HEIGHT = 9.125in

# original Prentice Hall paperback ISBN
#ISBN = 0-13-917568-7
# FIG ISBN
#ISBN = 0-93-553300-1
# a new ISBN needs to be purchased from the BoD publisher
# if the ISBN should make any sense.
ISBN = 0-9764587-0-5

# dummy price
PRICE = 90000
# USD 20 would be 42000
# For Lulu, the price consists of $4.53+pages*$0.02+1.2*royalty
# or 2*($1.56+pages*$0.02+1.2*royalty) for the ISBN plus service.
# pages rounded up to 4, last page empty.

PRINTING = "Punchy Printing"
OPTIONS = 6.14x9.21,2004,tip,tipno,leo,isbn,bnw
LANG = american
LINKCOLOR = blue
# for a printed version, use
#LINKCOLOR = black
# BoD options:
# 6x9 for 6" x 9" format (standard US book format)
# 17x22 for 17cm x 22cm format (one of the standard metric formats)
# 17x24 for 17cm x 24cm format (one of the standard metric formats)
# splitcover: if you only choose front and back, and the spine is done for you

VERSION = 1.0
CP = cp
TAR = tar jcf
MD = mkdir
RD = rm -rf
PS2PDF = ps2pdf13 -dPDFSETTINGS=/printer -dEmbedAllFonts=true

TOGETHER = 20 # how many pages you bind together - divide by 4
PSA4 = sed -e 's/%%BoundingBox:.*/%%PageSize: a4\n%%Orientation: Landscape/'
PSLET = sed -e 's/%%BoundingBox:.*/%%PageSize: letter\n%%Orientation: Landscape/'

all:	index pspdf cover

cover:	cover.pdf

#cover pngs (can be converted to TIFF or JPEG when needed)
cover-png:	cover.ps
	convert -density 300x300 cover.ps cover.png
	-mv cover.png.0 back.png
	-mv cover.png.1 spine.png
	-convert spine.png spine.ppm
	-pnmcrop -white spine.ppm >spine1.ppm
	-convert spine1.ppm spine.png
	-rm spine.ppm spine1.ppm
	-mv cover.png.2 front.png

dist:	$(ALL_SOURCES) $(PNGSOURCES) $(PNGSOURCES:.png=.eps)
	$(MD) thinking-forth-$(VERSION)
	$(CP) $(ALL_SOURCES) $(PNGSOURCES:.png=.eps) thinking-forth-$(VERSION)
	$(TAR) thinking-forth-$(VERSION).tar.bz2  thinking-forth-$(VERSION)
	$(RD) thinking-forth-$(VERSION)

pspdf:	thinking-forth.pdf

thinking-forth-book.pdf: thinking-forth-book.ps
	$(PS2PDF) $< $@

booka4 : thinking-forth.ps
	psbook -s$(TOGETHER) <$< | \
	psnup -c -2 -w$(WIDTH) -h$(HEIGHT) | \
	psresize -W$(WIDTH) -H$(HEIGHT) -w210mm -h297mm | \
	$(PSA4) >tf-a4.ps
	$(PS2PDF) tf-a4.ps tf-a4.pdf

bookletter : thinking-forth.ps
	psbook -s$(TOGETHER) <$< | \
	psnup -2 -w$(WIDTH) -h$(HEIGHT) | \
	psresize -W$(WIDTH) -H$(HEIGHT) -w8.5in -h11in | \
	$(PSLET) >tf-letter.ps
	$(PS2PDF) tf-letter.ps tf-letter.pdf

#two pages on one A4/Letter page, for printing with Laser printer and
#using an A4/Letter binding machine (print with long-edge
2on1.ps: thinking-forth.ps
	psselect -p4,1- $< | \
	pstops '2:0L@0.9(21.5cm,-0.5cm)+1L@0.9(21.5cm,13cm)' | \
	$(PSLET) >$@

tfoptions.tex:	Makefile
	echo "\def\tfoptions{$(OPTIONS)}" >$@
	echo "\def\tflang{$(LANG)}" >>$@
	echo "\def\isbn{$(ISBN)}" >>$@
	echo "\def\linkcolor{$(LINKCOLOR)}" >>$@
	echo "\def\printing{$(PRINTING)}" >>$@
	echo "\def\tfversion{$(VERSION)}" >>$@

%.pdf : %.ps
	$(PS2PDF) $< $@

pdf : $(SOURCES) $(PNGSOURCES:.png=.pdf)
	pdflatex thinking-forth.tex
	pdflatex thinking-forth.tex

ps :	thinking-forth.ps

dvi :	thinking-forth.dvi

%.ps	: %.dvi
	dvips $< -o - | sed -e "s,\`\`toFurther Thinking'',\"Further Thinking\",g" >$@


thinking-forth.dvi : $(SOURCES) $(PNGSOURCES:.png=.eps)
	latex thinking-forth.tex
	latex thinking-forth.tex

cover.dvi:	cover.tex backpage.tex isbn.eps tfoptions.tex pagecount.tex head.eps \
	leobrodie.eps #rodin_thinker.eps
	latex cover.tex

# get bookland.py from http://www.cgpp.com/bookland/

isbn.eps:	Makefile
	bookland.py $(ISBN) $(PRICE) >$@

pagecount.tex:	tfoptions.tex
	grep %%Pages: thinking-forth.ps | sed -e 's/%%Pages: \([0-9]*\)/\\def\\pagecount{\1}/g' | head -1 >$@

thinking-forth.idx: $(SOURCES) $(PNGSOURCES:.png=.eps)
	latex thinking-forth.tex

# makeindex log in: thinking-forth.ilg
index thinking-forth.ind: thinking-forth.idx
	makeindex thinking-forth.idx
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

#fig%.eps:	fig%.png
#	$(AUTOTRACE) $< >$@
#	./autoscale $@

#fig%.eps:	fig%.png
#	./poconv $@

#img%.eps:	img%.png
#	$(AUTOTRACE) $< >$@
#	./autoscale $@

#no-scrambled.eps:	no-scrambled.png
#	$(AUTOTRACE) $< >$@
#	./autoscale $@

no-scrambled.pdf:	no-scrambled.eps
	./eps2pdf $<

view : thinking-forth.dvi
	xdvi -s 6 -paper $(WIDTH:in=)x$(HEIGHT) thinking-forth.dvi
