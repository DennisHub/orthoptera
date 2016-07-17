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
\subsection{\textit{\tmpname}} \begin{minipage}[t]{0.55\textwidth} %
 \tmpgerman $\cdot$ \tmpslovenian $\cdot$ \tmpenglish %
 \paragraph{Description:} \tmpdescription \paragraph{Song:} \tmpsongdescription %
 \end{minipage} \hfill %
 \begin{minipage}[t]{0.4\textwidth} \mbox{} \\\\[-2ex] %
   \includegraphics[width=1.0\linewidth]{\tmpmaleimage}\\\\[-2ex]\hspace*{\fill}{\tiny \tmpmalesource} %
   \includegraphics[width=1.0\linewidth]{\tmpfemaleimage}\\\\[-2ex]\hspace*{\fill}{\tiny \tmpfemalesource} %
   \includegraphics[width=1.0\linewidth]{\tmpsongimage}\\\\[-2ex]\hspace*{\fill}{\tiny \tmpsongsource} %
 \end{minipage}}
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

\begin{document}

\section{Orthoptera of Skocjan, Slovenia}

EOF

for file in `find Orthoptera -name '*.tex' | sort`; do
    echo "\\graphicspath{{${file%/*.tex}/}}"
    echo "\\input{$file}"
done >> species.tex

echo '\end{document}' >> species.tex

pdflatex species.tex
