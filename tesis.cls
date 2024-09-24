\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tesis}[2024 tesis (Benjamin Edwards)]

%%%%%%%%%%% ir al repositorio (GitHub) por si hay actualizaciones
%% http://github.com/bedw8/template-tesis

\newif\ifspanish
\newif\ifenglish
\newif\ifbiblatex

% setting english as default
\englishtrue
\spanishfalse

\DeclareOption{english}{\englishtrue\spanishfalse}
\DeclareOption{spanish}{\spanishtrue\englishfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[twoside,12pt]{book}

% Version Septiembre 2024 - Benjamín Edwards
%   Se ordena más el main y se corrigen saltos de pagina (para doble pagina)
%   Se añaden recomendaciones / indicaciones de porqué usar Cleveref
%
%   TODO - añadir opciones para customizar logo y nombre de universidad

% Version 2023/24 - Benjamín Edwards
%	Se ordena la creación de la tapa y la pagina de reporte de aprobación.
%		Patrones que se repiten se agrupan en macros.
%		Se aprovecha más el paquete fancyhdr para encabezados y estilos de página

%	Se agrega el comando \psection para secciones en el prefacio
%	(Agradecimientos, biografia, resumen). A diferencia de \section,
%	su título y contenido quedan centrados. Estas secciones no están enumeradas
%	Por lo que en la tabla de contenidos (índice) aparecen sin números.
%	
%	Se agrega comando \postgrado que permite ingresar el grado (Magister o Doctorado). 
%		El grado ingresado se pone automatica en los sitios que corresponde en la tapa
%		y hoja de reporte

%	Borre hartas cosas que considero innecesarias
%		esas cosas las deje en un .sty de respaldo
%		Se recomienda usar \cref o \Cref en lugar de \ref. Estos comandos son del paquete cleveref

%	Agregué variables similares a \author para ingresar desde el preambulo

%	Hay comandos dinámicos que añaden directores de tesis o miembros de comisión 
%	evaluadora de forma sencilla
%		Si hay más de un director, directorES o advisorS
%		Se añade parámetro opcional que permite corregir "Director" por "Directora"
%	
%	Se implementa la opción de escoger entre idioma	español e ingles. \documentclass[spanish]{tesis}
%		El contenido de la tapa y de la hoja de reporte está para ambos idiomas.
%		Segun el idioma que se escoja se importa babel con las opciones adecuadas.
%		Para español
%			Se corrige el signo decimal para números con coma. 
%			TODO: Mantener et Al en la bibliografía 
%		


% Version 2.2.2 2010/12/29
%   Cuadro -> Tabla
%   Indice de Cuadros -> Indice de Tablas
%   (Gracias a Max Ramirez por la sugerencia)
% Version 2.2.1 2009/11/19
%   \documentclass[logo]{tesis}
% Version 2.2  2009/11/17
%   \documentclass[dosdirectores]{tesis}
% Version 2.1.5.2 2009/01/28
%   agrandar.sty se incluye en tar, de modo que tesis_doc.tex se 
%   puede compilar. (Gracias a Felipe Asenjo por notar el error.)
% Version 2.1.5.1 2008/08/21
%   tesis_doc.sty se incluye en tar, de modo que tesis_doc.tex se 
%   puede compilar. (Gracias a Max Ramirez por notar el error.)
% Version 2.1.5 2008/06/06
%   \begin{biografia}...\end{biografia} (Max Ramirez)
%   (Nueva seccion requerida)
%   Documentacion: \usepackage[latin1]{inputenc}
% Version 2.1.4.4 2008/02/05
%   Opcion txfonts carga txfonts.sty
%   Nueva abreviacion: \Cap -> \Capt (\Cap es algun comando
%     preexistente en modo matematico)
%   Titulo bibliografia: Referencia -> Referencias
% Version 2.1.4.3 2004/10/14
%   \RequirePackage{amssymb} (Alejandra Alvarez)
%   \RequirePackage{txfonts} (Alejandra Alvarez)
%   Agregar comando \facultad{Ciencias|Ciencias Fisicas y Matematicas}
%   Agregar comando \reviewtimetoday
% Version 2.1.4.2 2004/06/10
%   Magister en Ciencias con Mencion en Fisica 
%   -> Magister en Ciencias Fisicas
% Version 2.1.4.1 2004/06/09
%   \deactivatetilden
%   \decimalpoint
% Version 2.1.4 2004/06/02
%   \documentclass[doctorado]{tesis} (Default)
%   \documentclass[magister]{tesis}
% Version 2.1.3 2003/05/29
%   \usepackage{graphicx}
% Version 2.1.2 2003/05/14
%   \begin{aprueba}
%   \directorcomision
%   \begin{comision}
%   \miembro
%   \begin{gracias} 
% Version 2.1.1 2003/01/03
%   \makeaprueba
% Version 2.1 2002/12/04
%   \spain->\usepackage[english]{babel}
%   \usepackage{cite}
%   \maketapa
% Version 2.0 1999/11/16
%   Mejor modularizacion
% Version 1.0 1995/11/16
%%
%%   Modificado 16 Noviembre 1995, para que el item en el indice sea el
%%   mismo que el titulo del capitulo, y no del heading, y para que 
%%   la `i' acentuada de Capitulo quede bien en el heading. (Falta modificar 
%%   Bibliografia, y otros posibles.)
%% 
%%   Modificado desde `book.cls'.
%%
%%   Modificado para que 
%%   1) El default sea `oneside,12pt'
%%   2) Los nombres de secciones aparezcan en castellano
%%   3) La fecha aparezca en castellano
%%   4) Bibliografia aparezca bien acentuada en heading
%%   5) Los headings consten solo del numero de pagina.
%%       6) Los margenes sean: Superior = 3cm, Inferior = 3cm, 
%%                                                 Izquierdo = 4cm, Derecho = 2,5cm.
%%       7) El argumento opcional de \chapter vaya a Indice.
%%   8) Las Referencias aparezcan en Indice.
%%   9) Indice General -> Indice
%%   
%%

% En el tesis.cls original (tesiso.cls) la modificacion 7 hace que el 
% argumento opcional de \chapter vaya a Indice. Sin embargo, un argumento 
% opcional se uso solo para el Apendice. Pero los resultados de la compilacion 
% original son iguales a los de la compilacion con esta version de tesis.cls.
% Para que se hizo eso?

% En trabajo: Modificacion 8 de tesiso.cls. Lograr que Referencias
% aparezcan en Indice

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% tesis.cls %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Archivos suplementarios
%\RequirePackage{epsf} %TODO ver si es necesario
\ifspanish\RequirePackage[spanish, es-tabla,es-lcroman,es-nodecimaldot]{babel}\fi % idioma español
\ifenglish\RequirePackage[english]{babel}\fi % idioma ingles 
\RequirePackage{csquotes}
\RequirePackage{graphicx} % includgraphics pero con mas parametros, como cropear la figura
\RequirePackage{amssymb}  
\RequirePackage{mathrsfs} % Math fonts (makes a "Lagrangian" symbol)
\RequirePackage{amsmath}
%\RequirePackage{comment}  %TODO: ver si es necesario
\RequirePackage{tabularx}
\RequirePackage{import}
\RequirePackage{lhelp}
\RequirePackage{lipsum}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{enumerate}
\RequirePackage{xstring}
\RequirePackage{ifthen}

% Margenes
% Superior = 3cm, Inferior = 3cm,
% Izquierdo = 4cm, Derecho = 2.5cm

\RequirePackage[letterpaper,top=3cm,bottom=3cm,left=4cm,right=2.5cm]{geometry}

%%%% Secciones sin numero 
\let\originalsection\section
\RequirePackage{titlesec}
\titleformat{\section}{\centering\Large\bfseries}{}{0pt}{}
\let\prefacesection\section
\let\section\originalsection
\newcommand\psection[1]{%
\addcontentsline{toc}{chapter}{#1}
\prefacesection*{#1}
}
%%%%%

\RequirePackage[citecolor=blue]{hyperref} % Internal Links

% Cambios al default de spanish
\ifspanish\spanishdecimal{.}\fi
\ifspanish\deactivatetilden\fi
\ifspanish\decimalpoint\fi

% double spacing
\linespread{1.6}

%%%% Variables 

\def\@programa{Añadir programa académico}
\newcommand\postgrado[2][Postgrado]{
\def\@gradoacademico{#1}
\renewcommand\@programa{\@gradoacademico~#2}
}

\newcommand\pronom[1]{%
\def\@pronom{#1}%
\pronde%
\pronvocal%
}

\newcommand{\pronde}{
\ifthenelse{\equal{\@pronom}{el}}%
{\def\@pronde{del}}%
{\def\@pronde{de \@pronom}}%
}

\newcommand{\pronvocal}{
\ifthenelse{\equal{\@pronom}{el}}%
{\def\@pronvocal{o}}%
{\def\@pronvocal{\StrRight{\@pronom}{1}}}%
}

\renewcommand{\author}[2][el]{
	\renewcommand\@author{#2}
	\pronom{#1}
}

\newcounter{directores}
\setcounter{directores}{0}
\def\@dirplural{\ifenglish s\fi\ifspanish es\fi}
\def\@dirsuffix{\ifnum \value{directores}>1 \@dirplural\fi}
\newcommand\@directoresvar{%
\ifenglish advisor\fi%
\ifspanish director\fi%
\@dirsuffix
}

\newcommand{\maketapa}{%
\pagestyle{empty}
\vspace*{-3cm}
    \begin{center}
        \includegraphics[width=2cm]{uchile_full}
    \end{center}
    \begin{center}
        \LARGE\@title
    \end{center}
\vspace{1cm}
{\large
    \begin{center}%
    \vspace{-1cm}
    \ifenglish\bgroup Thesis submitted to Universidad de Chile\\
	in partial fulfillment of the requirements for the degree of\egroup\fi%
	\ifspanish\bgroup Tesis entregada a la Universidad de Chile en cumplimiento parcial de los requerimientos para el grado de\egroup \fi\\
    \emph{\@programa}\\
    \ifenglish Faculty of Sciences\fi%
	\ifspanish Facultad de Ciencias\fi\\[12mm]
    \ifenglish by\fi\ifspanish por\fi\\[12mm]
    \textbf{\@author}\\[5mm]
    \@date\\
\vspace{3cm}
\begingroup\singlespace%
\ifenglish Thesis \MakeTitlecase \@directoresvar: \fi%
\ifspanish \MakeTitlecase \@directoresvar~de Tesis: \fi%
\begin{tabular}[t]{l}
\@direcciontesis 
\end{tabular}%
\end{center}
\endgroup
}
\cleardoublepage
}

\renewcommand{\headrule}{}

\fancypagestyle{preface}{
\fancyhead{}
\fancyfoot{}
\fancyhead[LE,RO]{\thepage}
\pagenumbering{roman}
}

\fancypagestyle{everypage}{
\fancyhead{} % Empty headers
\fancyfoot[L]{} % Empty left footer
\fancyfoot[C]{\thepage}
\fancyfoot[R]{} % Empty center footer
\pagenumbering{arabic}
}

\def\@aprobacionfecha{}
\newcommand\aprobacionfecha[1]{\renewcommand\@aprobacionfecha{#1}}

\newcommand{\makeaprueba}{
\pagestyle{preface}
\begin{center}
\vspace{-5cm}
\ifenglish\bgroup FACULTY OF SCIENCES\\
UNIVERSIDAD DE CHILE\egroup\fi%
\ifspanish\bgroup FACULTAD DE CIENCIAS\\
UNIVERSIDAD DE CHILE\egroup\fi
\end{center}%\par
\vspace{.25cm}%\par
\begin{center}
\ifenglish\bgroup APPROVAL REPORT\\
\MakeUppercase{\@gradoacademico}~THESIS\egroup\fi%
\ifspanish\bgroup INFORME DE APROBACIÓN\\
TESIS DE \MakeUppercase{\@gradoacademico}\egroup\fi%
\end{center}\par
\vspace{.25cm}
\ifenglish The Graduate School of the Faculty of Sciences is informed that 
the \mbox{\@gradoacademico}'s Thesis presented by the candidate\fi%
\ifspanish Se informa a la Escuela de Postgrado de la Facultad de Ciencias que la Tesis de \mbox{\@gradoacademico} presentada~\@pronom~candidat\@pronvocal\fi%
\par
\begin{center}
\textbf\@author
\end{center}
%\par\noindent
\ifenglish has been approved by the Thesis Evaluation Committee as a requirement for the \mbox{\@gradoacademico's degree}, in the Private Thesis Defense examination given on \fi
\ifspanish ha sido aprobada por la Comisión de Evaluación de la Tesis como requisito para optar al grado de \mbox{\@gradoacademico}, en el examen de Defensa de Tesis rendido el \fi
\@aprobacionfecha.\\[.5cm]

\noindent\textbf{\ifenglish Thesis {\MakeTitlecase \@directoresvar}\fi\ifspanish {\MakeTitlecase \@directoresvar} de Tesis\fi}\\
\@direcciontesisAprueba

\noindent\textbf{\ifenglish Thesis Evaluation Committee\fi\ifspanish Comisión de Evaluación de la Tesis\fi}\\
\@comisiontesis

\cleardoublepage
}

\newcommand\apruebaFirma[1]{#1\hfill\rule{6cm}{\arrayrulewidth}\\}

\newcommand\@direcciontesis{}
\newcommand\@direcciontesisAprueba{}
\newcommand\anadirdireccion[2][]{
	\stepcounter{directores}
    \appto\@direcciontesis{{\bf \large #2 } \\}
    \appto\@direcciontesisAprueba{\apruebaFirma{#2}}
\ifx#1\empty\else \renewcommand\@dirsuffix{#1}\fi%
}

\newcommand\@comisiontesis{}
\newcommand\anadircomision[1]{
    \appto\@comisiontesis{\apruebaFirma{#1}}
}

\endinput
%% 
%% End of file `tesis.cls'.


