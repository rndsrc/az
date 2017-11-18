% Begin `az.cls' --- alpha version
%
% University of Arizona Ph.D. Thesis Document Class
%
% Written by Chi-kwan Chan (Spring 2007)

%==============================================================================
% Identification
%------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{az}[%
  2007/03/29%
  Department of Physics, the University of Arizona%
  Thesis Document Class%
]

%==============================================================================
% Initialization
%------------------------------------------------------------------------------
\newif\if@nice        \@nicefalse         % to format the thesis in a nice way
\newif\if@nocopyright \@nocopyrightfalse  % to leave copyright
\newif\if@master      \@masterfalse       % to make master thesis
\newif\if@majoreqdept \@majoreqdepttrue   % print major
\newif\if@onedirector \@onedirectortrue   % there is at least advisor
\newif\if@twodirectors\@twodirectorsfalse % second advisor

%==============================================================================
% Declaration of Options
%------------------------------------------------------------------------------
\DeclareOption{nice}       \@nicetrue
\DeclareOption{nocopyright}\@nocopyrighttrue
\DeclareOption{master}     \@mastertrue

%------------------------------------------------------------------------------
% Execution of Options
\ProcessOptions

%==============================================================================
% Package Loading
%------------------------------------------------------------------------------
\if@nice
  \PassOptionsToClass{letterpaper,12pt,twoside,onecolumn,final,openright}
		     {report}
\else
  \PassOptionsToClass{letterpaper,12pt,oneside,onecolumn,final,openright}
		     {report}
\fi
\LoadClass{report}

\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx,deluxetable}
\RequirePackage[round,colon,authoryear,sort&compress]{natbib}

%==============================================================================
% Hacks for Better Directory Handling
%------------------------------------------------------------------------------
% remember current directory.
\newcommand\@currentdirectory{.}
\newcommand\h@cksetdir[1]{\renewcommand\@currentdirectory{#1}}

%------------------------------------------------------------------------------
% hacked include to remember current directory:
% included stuff appears in new page.
\newcommand\h@ckinclude[2][.]{
  \h@cksetdir{#1}
  \relax
  \ifnum\@auxout=\@partaux
    \@latex@error{\string\include\space cannot be nested}\@eha
  \else
    \@include{\@currentdirectory/#2}
  \fi
}

% single spacing include
\newcommand\singleinclude[2][.]{
  \singlespacing
  \h@ckinclude[#1]{#2}
  \defaultspacing
}

% now pack the hacked include and in-line include together:
\renewcommand\include{\secdef\h@ckinclude\singleinclude}

% include only when the nice option is set
\newcommand\niceinclude[2][.]{\if@nice\include[#1]{#2}\fi}

%------------------------------------------------------------------------------
% hack includegraphics:
% so it remember current directory.
\newcommand\h@ckincludegraphics{
  \@ifstar{\Gin@cliptrue\Gin@i}{\Gin@clipfalse\Gin@i}
}

\renewcommand\includegraphics[2][]{
  \h@ckincludegraphics[#1]{\@currentdirectory/#2}
}

%==============================================================================
% Layout / Format
%------------------------------------------------------------------------------
% Page Layout:
% 1 inch = 72 pt.
\setlength{\hoffset       }{  0pt}
\setlength{\voffset       }{  0pt}
\setlength{\oddsidemargin }{ 36pt}
\setlength{\evensidemargin}{  0pt} % most people don't understand LaTeX!
\setlength{\topmargin     }{  4pt}
\setlength{\headheight    }{ 12pt}
\setlength{\headsep       }{ 20pt} % at least 0.25 inch = 18 pt so we are good
\setlength{\textheight    }{612pt} % = 8.5 inches, giving 1 inch bottom margin
\setlength{\textwidth     }{432pt} % = 6.0 inches, giving 1 inch right margin
\setlength{\marginparsep  }{  6pt}
\setlength{\marginparwidth}{ 30pt}
\setlength{\footskip      }{ 36pt}

%------------------------------------------------------------------------------
% Spacing:
% The fully `\large\normalsize' at the end of following comment ensure
% the spacing is actually applied.
\newcommand\singlespacing{\renewcommand\baselinestretch{1.2}\large\normalsize}
\newcommand\medianspacing{\renewcommand\baselinestretch{1.4}\large\normalsize}
\newcommand\doublespacing{\renewcommand\baselinestretch{1.6}\large\normalsize}

\if@nice
  \newcommand\defaultspacing{\singlespacing}
\else
  \newcommand\defaultspacing{\doublespacing}
\fi

\defaultspacing

%------------------------------------------------------------------------------
% Page Style:
% page numbers in upper-right corner.
\def\ps@plain{%
  \setlength{\headsep   }{ 20pt}
  \setlength{\textheight}{612pt}
  \let\@mkboth\@gobbletwo
  \def\@oddhead{\reset@font\hfil\thepage}%
  \let\@oddfoot\@empty
  \def\@evenhead{\reset@font\thepage\hfil}%
  \let\@evenfoot\@empty%
}

\def\ps@toc{%
  \setlength{\headsep   }{ 56pt}
  \setlength{\textheight}{576pt}
  \def\@oddhead{\reset@font\raisebox{-32pt}%
    {\MakeUppercase{\contentsname} --- Continued}%
    \hfil\thepage}%
  \let\@oddfoot\@empty
  \def\@evenhead{\reset@font\thepage\hfil}%
  \let\@evenfoot\@empty%
}

\def\ps@lof{%
  \setlength{\headsep   }{ 56pt}
  \setlength{\textheight}{576pt}
  \def\@oddhead{\reset@font\raisebox{-32pt}%
    {\MakeUppercase{\listfigurename} --- Continued}%
    \hfil\thepage}%
  \let\@oddfoot\@empty
  \def\@evenhead{\reset@font\thepage\hfil}%
  \let\@evenfoot\@empty%
}

\def\ps@lot{%
  \setlength{\headsep   }{ 56pt}
  \setlength{\textheight}{576pt}
  \def\@oddhead{\reset@font\raisebox{-32pt}%
    {\MakeUppercase{\listtablename} --- Continued}%
    \hfil\thepage}%
  \let\@oddfoot\@empty
  \def\@evenhead{\reset@font\thepage\hfil}%
  \let\@evenfoot\@empty%
}

\pagestyle{plain}

%------------------------------------------------------------------------------
% Table of Contents, etc
\setcounter{secnumdepth}{3}

\renewcommand\contentsname{Table of Contents}

\def\l@chapter{\@dottedtocline{0}{0em}{1.4em}}%

\def\tableofcontents{%
  \if@nice\else\pagestyle{toc}\fi
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn\fi
    \chapter*{\contentsname}
    \@starttoc{toc}
    \if@restonecol\twocolumn\fi
  \if@nice\cleardoublepage\else\clearpage\pagestyle{plain}\fi%
}

\def\listoffigures{%
  \if@nice\else\pagestyle{lof}\fi
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn\fi
    \addcontentsline{toc}{chapter}{\MakeUppercase{\listfigurename}}
    \chapter*{\listfigurename}
    \@starttoc{lof}
    \if@restonecol\twocolumn\fi
  \if@nice\cleardoublepage\else\clearpage\pagestyle{plain}\fi%
}

\def\listoftables{%
  \if@nice\else\pagestyle{lot}\fi
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn\fi
    \addcontentsline{toc}{chapter}{\MakeUppercase{\listtablename}}
    \chapter*{\listtablename}
    \@starttoc{lot}
    \if@restonecol\twocolumn\fi
  \if@nice\cleardoublepage\else\clearpage\pagestyle{plain}\fi%
}

%------------------------------------------------------------------------------
% Redefine chapter:
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{chapter}%
      {\MakeUppercase{\@chapapp~\protect\numberline{\thechapter:}#1}}%
  \else
    \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi%
}

\def\@makechapterhead#1{%
  \vspace{24pt}{%
    \parindent\z@
    \ifnum \c@secnumdepth >\m@ne
      \begin{center}\large\bfseries\uppercase{\@chapapp\space\thechapter}\end{center}
      \par\nobreak
      \vspace{12pt}
    \fi
    \interlinepenalty\@M
    \begin{center}\large\bfseries\uppercase{#1}\end{center}
    \par\nobreak
    \vspace{24pt}%
  }%
}

\def\@makeschapterhead#1{%
  \vspace{24pt}{%
    \parindent\z@
    \interlinepenalty\@M
    \centerline{\large\bfseries\MakeUppercase{#1}}
    \par\nobreak
    \vspace{24pt}%
  }%
}

%------------------------------------------------------------------------------
% Redefine section:
\renewcommand\section{\@startsection
  {section}{1}{0pt}{12pt}{12pt}{\centering\large\bfseries}}

% Redefine subsection:
\renewcommand\subsection{\@startsection
  {subsection}{2}{0pt}{12pt}{12pt}{\centering\normalsize\bfseries}}

% Redefine subsubsection:
\renewcommand\subsubsection{\@startsection
  {subsubsection}{3}{0pt}{12pt}{12pt}{\centering\normalsize\bfseries}}

%------------------------------------------------------------------------------
% footnote:
\addtolength{\skip\footins}{12pt}
\setlength{\footnotesep}{12pt}
\long\def\@footnotetext#1{\insert\footins{
  \def\baselinestretch{1.2}\footnotesize
  \interlinepenalty\interfootnotelinepenalty
  \splittopskip\footnotesep
  \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
  \hsize\columnwidth \@parboxrestore
  \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
		     {\rule\z@\footnotesep\ignorespaces#1\strut}
}}

%------------------------------------------------------------------------------
% bibliography:
\renewcommand\bibname{References}

\renewenvironment{thebibliography}[1]{\singlespacing%
  \addcontentsline{toc}{chapter}{\MakeUppercase{\bibname}}%
  \chapter*{\bibname}%
  \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m%
}

%==============================================================================
% Main Code
%------------------------------------------------------------------------------
% Title Page information:
\renewcommand\date[3]{\gdef\@month{#1}\gdef\@date{#2}\gdef\@year{#3}}
\newcommand\department[1]{\gdef\@department{#1}}
\newcommand\major[1]{\@majoreqdeptfalse\gdef\@major{#1}}
\newcommand\committee[5]{
  \gdef\@committeeone  {#1}
  \gdef\@committeetwo  {#2}
  \gdef\@committeethree{#3}
  \gdef\@committeefour {#4}
  \gdef\@committeefive {#5}
}
\newcommand\twodirectors\@twodirectorstrue

% Title pages including the cover and approval page:
\def\maketitle{\par
  \@makecover
  \@makeapproval
  \@makestatement
  \let\maketitle\relax
  \let\@makecover\relax
  \let\@makeapproval\relax
  \let\@makestatement\relax
}

% Make Cover Page:
\def\@makecover{
  \newpage
  \singlespacing
  \thispagestyle{empty}
  \begin{center}
  \vspace*{72pt}

    \uppercase\expandafter{\@title}\\
    \vspace*{24pt}by\\
    \vspace*{12pt}\@author\\

  \vspace*{72pt}

    \rule{3in}{.5pt}\\
    \if@nocopyright
      \vspace*{-6pt}\ \\
    \else
      \vspace*{-6pt}Copyright \copyright\ \@author\ \@year\\
    \fi

  \vspace*{24pt}

    A Dissertation Submitted to the Faculty of the\\
    \vspace*{12pt}
    DEPARTMENT OF \MakeUppercase{\@department}\\
    \vspace*{12pt}
    In Partial Fulfillment of the Requirements\\
    For the Degree of\\
    \vspace*{12pt}
    DOCTOR OF PHILOSOPHY\\
    \if@majoreqdept\else
      WITH A MAJOR IN \MakeUppercase{\@major}\\
    \fi
    \vspace*{12pt}
    In the Graduate College\\
    \vspace*{12pt}
    THE UNIVERSITY OF ARIZONA\\

  \vfill

    \@year

  \end{center}
  \cleardoublepage
  \defaultspacing
}

% Make Approval Page
%   Yes!  I know what I am doing!!!  The extremely dirty trick presented
%   here makes sure the spacings between each signature lines are the
%   same; even through there are special characters in your advisor's
%   name...
\def\@makeapproval{
  \newpage
  \singlespacing

    \centerline{THE UNIVERSITY OF ARIZONA}
    \centerline{GRADUATE COLLEGE}

  \vspace*{24pt}

    \def\\{}
    \noindent As members of the Dissertation Committee, we certify
    that we have read the dissertation prepared by \@author\ entitled
    ``\@title'' and recommend that it be accepted as fulfilling the
    dissertation requirement for the Degree of Doctor of Philosophy.
    \def\\{\linebreak}

  \vspace*{12pt}

    \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
    \vspace*{-6pt}\\\rule[-6pt]{0pt}{24pt}\@committeeone

    \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
    \vspace*{-6pt}\\\rule[-6pt]{0pt}{24pt}\@committeetwo

    \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
    \vspace*{-6pt}\\\rule[-6pt]{0pt}{24pt}\@committeethree

    \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
    \vspace*{-6pt}\\\rule[-6pt]{0pt}{24pt}\@committeefour

    \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
    \vspace*{-6pt}\\\rule[-6pt]{0pt}{24pt}\@committeefive

  \vspace*{12pt}

    \noindent Final approval and acceptance of this dissertation is
    contingent upon the candidate's submission of the final copies of
    the dissertation to the Graduate College.

    \noindent I hereby certify that I have read this dissertation
    prepared under my direction and recommend that it be accepted as
    fulfilling the dissertation requirement.

  \vspace*{12pt}

    \if@onedirector
      \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
      \vspace*{-6pt}\\
      \rule[-6pt]{0pt}{24pt}Dissertation~Director:~\@committeeone
    \fi

    \if@twodirectors
      \noindent\rule{0pt}{0.4in}\hrulefill~Date:~\@month/\@date/\@year
      \vspace*{-6pt}\\
      \rule[-6pt]{0pt}{24pt}Dissertation~Director:~\@committeetwo
    \fi

  \cleardoublepage
  \defaultspacing
}

\def\@makestatement{
  \newpage
  \singlespacing
  \vspace*{72pt}

    \centerline{STATEMENT BY AUTHOR}

  \vspace*{24pt}

    This dissertation has been submitted in partial fulfillment of
    requirements for an advanced degree at the University of Arizona
    and is deposited in the University Library to be made available to
    borrowers under rules of the Library.

  \vspace*{12pt}

    Brief quotations from this dissertation are allowable without
    special permission, provided that accurate acknowledgment of
    source is made.  Requests for permission for extended quotation
    from or reproduction of this manuscript in whole or in part may be
    granted by
    \if@nocopyright
      the head of the major department or the Dean of the Graduate
      College when in his or her judgment the proposed use of the
      material is in the interests of scholarship.  In all other
      instances, however, permission must be obtained from the author.
    \else
      the copyright holder.
    \fi

  \vspace*{36pt}

    \hfill{SIGNED:}~\underline{\hspace{216pt}}

  \cleardoublepage
  \defaultspacing
}

%==============================================================================
% End `az.cls'
