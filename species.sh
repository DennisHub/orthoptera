#!/bin/bash

speciespath="species"
mkdir $speciespath

cat <<EOF > $speciespath/species.tex
\documentclass[11pt,a4paper]{article}
\usepackage[top=20mm,left=20mm,right=20mm,bottom=20mm]{geometry}
\usepackage{xcolor}
\usepackage{graphicx}
\setcounter{secnumdepth}{-1}
\newcommand{\species}[9]{%
\def\tmpname{#1}%
\def\tmpgerman{#2}%
\def\tmpslovenian{#3}%
\def\tmpenglish{#4}%
\def\tmpmaleimage{#5}%
\def\tmpmalesource{#6}%
\def\tmpfemaleimage{#7}%
\def\tmpfemalesource{#8}%
\def\tmpdescription{#9}%
\speciescontinued
}
\newcommand\speciescontinued[3]{
\def\tmpsongdescription{#1}%
\def\tmpsongimage{#2}%
\def\tmpsongsource{#3}%
\noindent\begin{minipage}{1\textwidth} %
\subsubsection[\tmpname]{\colorbox{black!20}{\rule[-1ex]{0pt}{3ex}\parbox{0.99\textwidth}{\textit{\tmpname}}}} %
\vspace{-1ex} {\tmpgerman} $\cdot$ {\tmpslovenian} $\cdot$ {\tmpenglish} \\\\[1ex]%
\parbox[b]{0.48\linewidth}{\includegraphics[height=37mm]{\tmpmaleimage}\\\\[-1.8ex]{\tiny \tmpmalesource}} \hspace*{\fill} %
\parbox[b]{0.48\linewidth}{\includegraphics[height=37mm]{\tmpfemaleimage}\\\\[-1.8ex]{\tiny \tmpfemalesource}} \\\\[1ex] %
\begin{minipage}[b]{0.48\textwidth} %
 \paragraph{Description:} \tmpdescription \paragraph{Song:} \tmpsongdescription %
 \end{minipage} \hfill %
 \begin{minipage}[b]{0.48\textwidth} %
   \includegraphics[width=1.0\linewidth]{\tmpsongimage}\\\\[-1.8ex]{\tiny \tmpsongsource} %
 \end{minipage}\end{minipage}\vfill}
% 1 species
% 2 german
% 3 slovenia
% 4 english
% 5 male photo
% 6 male photo source
% 7 female photo
% 8 female photo source
% 9 description
% 10 song description
% 11 song figure
% 12 song figure source

\usepackage[colorlinks=true,urlcolor=black]{hyperref}

\begin{document}

\section{Orthoptera of Skocjan, Slovenia}

EOF

echo '\subsection{Ensifera}' >> $speciespath/species.tex
for file in `find Ensifera -name '*.tex' | sort`; do
    spath=${file%/*.tex}
    for image in $spath/*.jpg $spath/*.png; do
	imagename=${image##*/}
	if test -f $image && ! test -f $speciespath/$imagename; then
	    echo "converting " $imagename > /dev/stderr
	    convert -resize 600 $image $speciespath/$imagename
	fi
    done
    echo "collecting " ${file##*/} > /dev/stderr
    cat $file
    echo ""
done >> $speciespath/species.tex

echo '\subsection{Caelifera}' >> $speciespath/species.tex
for file in `find Caelifera -name '*.tex' | sort`; do
    spath=${file%/*.tex}
    for image in $spath/*.jpg $spath/*.png; do
	imagename=${image##*/}
	if test -f $image && ! test -f $speciespath/$imagename; then
	    echo "converting " $imagename > /dev/stderr
	    convert -resize 600 $image $speciespath/$imagename
	fi
    done
    echo "collecting " ${file##*/} > /dev/stderr
    cat $file
    echo ""
done >> $speciespath/species.tex

echo '\end{document}' >> $speciespath/species.tex

cd $speciespath/
pdflatex species.tex
cp species.pdf ..
cd -

