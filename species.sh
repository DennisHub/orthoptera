#!/bin/bash

cat <<EOF > species.tex
\documentclass[11pt,a4paper]{article}
\usepackage[top=20mm,left=20mm,right=20mm,bottom=20mm]{geometry}
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
\subsubsection{\textit{\tmpname}} %
\vspace{-1ex} {\tmpgerman} $\cdot$ {\tmpslovenian} $\cdot$ {\tmpenglish} \\\\[1ex]%
\parbox[b]{0.48\linewidth}{\includegraphics[height=4cm]{\tmpmaleimage}\\\\[-1.8ex]{\tiny \tmpmalesource}} \hspace*{\fill} %
\parbox[b]{0.48\linewidth}{\includegraphics[height=4cm]{\tmpfemaleimage}\\\\[-1.8ex]{\tiny \tmpfemalesource}} \\\\[1ex] %
\begin{minipage}[b]{0.55\textwidth} %
 \paragraph{Description:} \tmpdescription \paragraph{Song:} \tmpsongdescription %
 \end{minipage} \hfill %
 \begin{minipage}[b]{0.4\textwidth} %
   \includegraphics[width=1.0\linewidth]{\tmpsongimage}\\\\[-1.8ex]{\tiny \tmpsongsource} %
 \end{minipage}\vspace{2ex}\par}
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

echo '\subsection{Ensifera}' >> species.tex
for file in `find Ensifera -name '*.tex' | sort`; do
    echo "\\graphicspath{{${file%/*.tex}/}}"
    echo "\\input{$file}"
    echo ""
done >> species.tex

echo '\subsection{Caelifera}' >> species.tex
for file in `find Caelifera -name '*.tex' | sort`; do
    echo "\\graphicspath{{${file%/*.tex}/}}"
    echo "\\input{$file}"
    echo ""
done >> species.tex

echo '\end{document}' >> species.tex

pdflatex species.tex
