\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hnuthesis}
    [2017/07/19 v0.1 HNU thesis template]

% 变量
\newif\if@hnu@doctor
\newif\if@hnu@numerical
\newif\if@hnu@super
\newif\if@hnu@pdf
\DeclareOption{doctor}{\@hnu@doctortrue}
\DeclareOption{print}{\@hnu@pdffalse}
\DeclareOption{pdf}{\@hnu@pdftrue}
\DeclareOption{super}{\@hnu@numericaltrue\@hnu@supertrue}
\DeclareOption{numbers}{\@hnu@numericaltrue\@hnu@superfalse}
\DeclareOption{authoryear}{\@hnu@numericalfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{doctor,chinese,print,super}
\ProcessOptions\relax
\newif\if@hnu@addtocspace
\if@hnu@pdf
  \PassOptionsToClass{oneside}{book}
\fi
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[UTF8, a4paper, openany, zihao=-4]{ctexbook}[2015/05/14]
\RequirePackage{etoolbox}
\@ifclasslater{ctexbook}{2015/05/14}{}{%
    \ClassError{hnuthesis}{%
        Requiring ctex 2.0 or later version!\MessageBreak
        Please update the package using your\MessageBreak
        TeX package manager or from CTAN
    }{%
        See logs for more details.
    }
}
\setmainfont{Times New Roman}
\setsansfont{Times New Roman} % 设置英文黑体为 Times New Roman
\setCJKmainfont{[simsun.ttc]}
\setCJKsansfont{[simhei.ttf]} % 中文黑体保持使用黑体Å
\RequirePackage{hyperref}
\hypersetup{
    bookmarksopen=true,
    bookmarksnumbered=true,
    bookmarksopenlevel=1,
    CJKbookmarks=true,
    pdfborder=0 0 0,
    unicode=true,
    linktoc=all,
}
\if@hnu@pdf
    \hypersetup{
        colorlinks=true,
        allcolors=blue,
    }
\fi

\AtBeginDocument{
    \hypersetup{
        pdftitle={\hnu@title},
        pdfauthor={\hnu@author}
    }
}

\RequirePackage{xparse}
\NewDocumentCommand\setfontsize{mo}{\IfValueTF{#2}{\fontsize{#1}{#2}}{\fontsize{#1}{2\dimexpr#1}}\linespread{1}\selectfont\relax}
\newcommand\zhspace[1][1]{\hspace{#1\ccwd}}
\newcommand\hnu@underline[2][6em]{%
    \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt\relax
}
\def\hnu@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{
        \expandafter\gdef\csname hnu@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}
\hnu@define@term{hnucode}
\hnu@define@term{hnuname}
\hnu@define@term{title}
\hnu@define@term{pagetitle}
\hnu@define@term{clc}
\hnu@define@term{secrettext}
\hnu@define@term{author}
\hnu@define@term{authorid}
\hnu@define@term{college}
\hnu@define@term{major}
\hnu@define@term{workon}
\hnu@define@term{supervisor}
\hnu@define@term{cosupervisor}
\hnu@define@term{submitdate}
\hnu@define@term{defensedate}
\hnu@define@term{chair}
\hnu@define@term{entitle}
\hnu@define@term{enauthor}
\hnu@define@term{enmajor}
\hnu@define@term{endoctor}
\hnu@define@term{enmaster}
\hnu@define@term{enbachelor}
\hnu@define@term{enhnuname}
\hnu@define@term{ensupervisor}
\hnu@define@term{encosupervisor}
\hnu@define@term{endate}

\if@hnu@doctor
  \newcommand\hnu@thesisname{硕士学位论文}%
\fi

% 表格：
% 三线表
\RequirePackage{booktabs}
\RequirePackage{multirow}
% 跨页表格
% \RequirePackage{longtable}



% 题注、标题
\renewcommand\listfigurename{插图索引}
\renewcommand\listtablename{附表索引}
\newcommand\hnu@notesname{\textbf{注}：}
\newcommand\hnu@enabstractname{\textbf{\textrm{Abstract}}}
\newcommand\hnu@abstractname{摘\quad 要}
\newcommand\hnu@acknowledgementsname{致\quad 谢}
\newcommand\hnu@committeename{答辩委员会名单}
\newcommand\hnu@tocname{目\quad 录}
\newcommand\hnu@summaryname{总结与展望}
\newcommand\hnu@notationname{符号说明}
\def\equationautorefname~#1\null{公式~(#1)\null}%
\def\footnoteautorefname{脚注}%
\def\itemautorefname~#1\null{第~#1~项\null}%
\def\figureautorefname{图}%
\def\tableautorefname{表}%
\def\partautorefname~#1\null{第~#1~部分\null}%
\def\appendixautorefname{}%
\def\chapterautorefname~#1\null{第~#1~章\null}%
\def\sectionautorefname~#1\null{第~#1~节\null}%
\def\subsectionautorefname~#1\null{第~#1~小节\null}%
\def\subsubsectionautorefname~#1\null{第~#1~小小节\null}%
\def\paragraphautorefname~#1\null{第~#1~段\null}%
\def\subparagraphautorefname~#1\null{第~#1~小段\null}%
\def\theoremautorefname{定理}%
\def\pageautorefname~#1\null{第~#1~页\null}%

% 页面设置 % update 04/2025
\RequirePackage{geometry}
\geometry{
    paper=a4paper,
    top=2.5cm, bottom=2.5cm,
    left=3.0cm, right=3.0cm,
    headheight=0.2cm, headsep=1.3cm,
    footskip=1.5cm}
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{hnu@headings}{%
  \fancyhf{}%
  \fancyhead[CE]{\setfontsize{9pt}\hnu@pagetitle}%
  \fancyhead[CO]{\setfontsize{9pt}\hnu@thesisname}
  \fancyfoot[C]{\setfontsize{9pt}\thepage}
  \fancyheadoffset[LO,LE]{3mm}
  \fancyheadoffset[RO,RE]{-3mm}
  \makeatletter
  \def\headrule{
    \if@fancyplain\let\headrulewidth\plainheadrulewidth\fi%
    \hrule\@height 1.0pt \@width\headwidth\vskip 1pt %上面线为1pt粗
    \hrule\@height 0.5pt \@width\headwidth  %下面0.5pt粗
    \vskip-2\headrulewidth\vskip-1pt}      %两条线的距离1pt
    \vspace{7mm}
}%

\fancypagestyle{hnu@notation}{\fancyfoot{}}
\pagestyle{hnu@headings}
\patchcmd\chaptermark{#1}{\protect\spacetitle{#1}}{}{}
\renewcommand*{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\g@addto@macro\frontmatter{%
  \pagenumbering{Roman}%
}
\renewcommand\mainmatter{%
  \clearpage
  \pagenumbering{arabic}%
  \@mainmattertrue
}

% 列表
\RequirePackage{enumitem}
\setitemize{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=-0em}
\setenumerate{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em}

% 章节、段落、页眉、页脚
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \setlength{\baselineskip}{20pt}
  %\renewcommand{\CJKglue}{\hskip 0.5pt plus \baselineskip}
  \global\@topnum\z@
  \@afterindenttrue
  \secdef\@chapter\@schapter
}

\RequirePackage{pifont}
\def\hnu@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{hnuthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ding{\the\numexpr\value{#1}+191\relax}
}

\RequirePackage{stringstrings}
\newcounter{titlelength}
\newcommand\spacetitle[1]{%
  \@getstringlength{#1}{titlelength}%
  \ifnum\thetitlelength=2{\ziju{2}#1}\else%
    \ifnum\thetitlelength=3{\ziju{1}#1}\else%
      \ifnum\thetitlelength=4{\ziju{0.5}#1}\else#1%
      \fi
    \fi
  \fi
}
\setcounter{secnumdepth}{5}
\ctexset{
    chapter = {
        format      = \centering\sffamily\bfseries\setfontsize{18pt},
        nameformat  = {},
        % titleformat = \spacetitle,
        number      = \thechapter,
        aftername   = \hspace{\ccwd},
        beforeskip  = -2.5em, % 24bp - 31bp
        afterskip   = 1.5em, % 18bp - 10bp
        % fixskip   = true, % will be used in future version
    },
    section = {
        format     = \bf\sffamily\setfontsize{15pt},
        aftername  = \hspace{\ccwd},
        beforeskip = 12pt,
        afterskip  = 12pt,
    },
    subsection = {
        format     = \bf\sffamily\setfontsize{14pt},
        aftername  = \hspace{\ccwd},
        % indent     = 2\ccwd,
        beforeskip = 6pt,
        afterskip  = 6pt,
    },
    subsubsection = {
        format    = \sffamily\setfontsize{12.5pt},
        number    = (\arabic{subsubsection}),
        % aftername = \hspace{\ccwd},
        beforeskip = 6pt,
        afterskip  = 6pt,
        % indent    = 3\ccwd,
    },
    paragraph = {
        format    = \sffamily\setfontsize{12.5pt},
        number    = (\arabic{paragraph}),
        aftername = \hspace{\ccwd},
        % indent    = 3\ccwd,
    },
    subparagraph = {
        format    = \sffamily\setfontsize{12.5pt},
        number    = \hnu@textcircled{subparagraph},
        aftername = \hspace{\ccwd},
        % indent    = 3\ccwd,
    },
}

% 书签
\newcounter{hnu@pdfbookmark}
\NewDocumentCommand\hnu@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \addtocounter{hnu@pdfbookmark}\@ne
  \IfValueTF{#1}{%
    \chaptermark{#1}%
  }{%
    \chaptermark{#2}%
  }%
  \chapter*{#2}
}

% 封面
\renewcommand\maketitle{%
    \pagenumbering{gobble}
    \pdfbookmark[0]{封面}{titlepage}
    \make@cntitle
    \pdfbookmark[0]{Title page}{entitlepage}
    \make@entitle
    \pdfbookmark[0]{学位论文原创性声明和学位论文版权使用授权书}{statement}
    \make@statement
}

\newcommand\hnu@supervisorline{%
  \ifx\hnu@encosupervisor\@empty%
    Supervisor: \hnu@ensupervisor%
  \else%
    Supervisors: \hnu@ensupervisor, \hnu@encosupervisor%
  \fi}

\RequirePackage{tikz}
\newcommand\vpostext[2]{%
  \tikz[remember picture,overlay]%
      \node [yshift=-#1] at (current page.north) [below,align=flush center]%
          {\parbox{\textwidth}{\centering#2}};
}

\newcommand\linetext[3]{%
  \underline{\makebox[#1][#2]{#3}}
}


% 中文封面
\RequirePackage{tabularx}
\newcommand\make@cntitle{%
  \begin{titlepage}%
      \vpostext{5cm}{\includegraphics[height=3cm]{figures/hnu_logo.png}}%
      \vpostext{9.5cm}{\bf\sffamily\setfontsize{22pt}\hnu@thesisname}%
      \vpostext{13.5cm}{\bf\sffamily\setfontsize{26pt}\hnu@title}%

      \tikz[remember picture,overlay]
        \node [xshift=5cm,yshift=-20cm] at (current page.north west)%
            [below right,align=left] {%
          \newlength{\@tw}
          \setlength{\@tw}{94pt}
          \newlength{\@cw}
          \setlength{\@cw}{6.4cm}

          \setfontsize{12.5pt}%
          \begin{tabular}{@{}l@{\hspace{\ccwd}}l@{}}%
            \makebox[\@tw][s]{\sffamily\textbf{作者姓名}} & \makebox[\@cw][l]{\qquad\hnu@author} \\%
            \makebox[\@tw][s]{\sffamily\textbf{指导老师}} & \begin{tabular}[t]{@{}l@{}}
                                                                \makebox[\@cw][l]{\qquad \hnu@supervisor} \\  % 学业导师
                                                                \makebox[\@cw][l]{\qquad \hnu@cosupervisor}     % 企业导师
                                                        \end{tabular} \\
            \makebox[\@tw][s]{\sffamily\textbf{培养单位}} & \makebox[\@cw][l]{\qquad\hnu@college} \\
            \makebox[\@tw][s]{\sffamily\textbf{专业类别}} & \makebox[\@cw][l]{\qquad\hnu@major} \\
            \makebox[\@tw][s]{\sffamily\textbf{专业领域}} & \makebox[\@cw][l]{\qquad\hnu@workon} \\
          \end{tabular}};%

      \clearpage
      \thispagestyle{empty}

      \tikz[remember picture,overlay]
        \node [xshift=5cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {%

          \setlength{\@tw}{66.5pt}
          \setlength{\@cw}{8cm}

          \setfontsize{12pt}%
          \begin{tabularx}{\linewidth}{ll}%
            \makebox[\@tw][s]{\sffamily\textbf{学校代码}} & \linetext{\@cw}{l}{\hspace{1\ccwd}\hnu@hnucode} \\
            \makebox[\@tw][s]{\sffamily\textbf{学号}} & \linetext{\@cw}{l}{\hspace{1\ccwd}\hnu@authorid} \\
            \makebox[\@tw][s]{\sffamily\textbf{密级}} & \linetext{\@cw}{l}{\hspace{1\ccwd}\hnu@secrettext}
          \end{tabularx}};%

      \tikz[remember picture,overlay]
        \node [xshift=5.4cm,yshift=-8cm] at (current page.north west)%
            [below right,align=left]%
            {\parbox{\textwidth}{\setfontsize{18pt}\hnu@hnuname\hnu@thesisname}};

      \tikz[remember picture,overlay]
        \node [xshift=5.4cm,yshift=-12cm] at (current page.north west)%
            [below right,align=left]%
            {\parbox{12cm}{\bf\sffamily\setfontsize{22pt}\hnu@title}};

      \tikz[remember picture,overlay]
        \node [xshift=5.2cm,yshift=-18cm] at (current page.north west)%
            [below right,align=left] {%
          \setlength{\@tw}{107pt}
          \setlength{\@cw}{9.5cm}

          \setfontsize{12.5pt}%
          \begin{tabular}{@{}l}%
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{作者姓名：}}{\hspace{3\ccwd}}\hnu@author} \\%
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{指导老师：}}{\hspace{3\ccwd}}\hnu@supervisor}\\
            \makebox[\@tw][s]{~}\linetext{\dimexpr\@cw-\@tw\relax}{l}{{\hspace{3\ccwd}}\hnu@cosupervisor} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{培养单位：}}{\hspace{3\ccwd}}\hnu@college} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{专业类别：}}{\hspace{3\ccwd}}\hnu@major} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{专业领域：}}{\hspace{3\ccwd}}\hnu@workon} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{论文提交日期：}}{\hspace{3\ccwd}}\hnu@submitdate} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{论文答辩日期：}}{\hspace{3\ccwd}}\hnu@defensedate} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{答辩委员会主席：}}{\hspace{3\ccwd}}\hnu@chair}
          \end{tabular}};%
    \end{titlepage}
}

% 英文封面
\newcommand\make@entitle{%
    \begin{titlepage}%
        \vpostext{3.9cm}{\setfontsize{15pt} \leavevmode \hnu@entitle}%
        \vpostext{6.5cm}{\setfontsize{12pt} by}%
        \vpostext{7.75cm}{\setfontsize{12pt} \hnu@enauthor}%
        \vpostext{9.0cm}{\setfontsize{12pt} \hnu@enbachelor}%
        \vpostext{10.25cm}{\setfontsize{12pt} A thesis submitted in partial satisfaction of the}%
        \vpostext{11.5cm}{\setfontsize{12pt} requirements for the degree of}%
        \vpostext{12.75cm}{\setfontsize{12pt} \hnu@endoctor}%
        \vpostext{14.0cm}{\setfontsize{12pt} in}%
        \vpostext{15.25cm}{\setfontsize{12pt} \hnu@enmajor}%
        \vpostext{16.5cm}{\setfontsize{12pt} in the}%
        \vpostext{17.75cm}{\setfontsize{12pt} Graduate School}%
        \vpostext{19.0cm}{\setfontsize{12pt} of}%
        \vpostext{20.25cm}{\setfontsize{12pt} \hnu@enhnuname}%
        \vpostext{21.5cm}{\setfontsize{12pt} Supervisor}%
        \vpostext{22.75cm}{\setfontsize{12pt} \hnu@ensupervisor}%
        \vpostext{24.0cm}{\setfontsize{12pt} \hnu@encosupervisor}%
        \vpostext{25.25cm}{\setfontsize{12pt} \hnu@endate}%
    \end{titlepage}
}

% 声明
\newcommand{\hnu@declaretext} {
本人郑重声明：所呈交的论文是本人在导师的指导下独立进行研究所取得的研究成果。除了文中特别加以标注引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写的成果作品。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律后果由本人承担。
}

\newcommand{\hnu@authorization}{
本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权湖南大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

涉密学位论文在解密后适用本授权书。
}


\newcommand\make@statement{
    \thispagestyle{empty}
    \pagenumbering{Roman}
    % \addcontentsline{toc}{chapter}{学位论文原创性声明和学位论文版权使用授权书}
    \setfontsize{12pt}[20pt]
    \vspace*{-0.15cm}
    \begin{center}
      \sffamily
      \setfontsize{18pt}
      \makebox[3.5cm][s]{\textbf\hnu@hnuname}\\
      \textbf{学位论文原创性声明}
    \end{center}
    \vskip 0.3cm

    \hnu@declaretext\par

    \vskip 1cm
    作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
    \vskip 1cm

    \begin{center}
      \sffamily
      \setfontsize{18pt}\textbf{学位论文版权使用授权书}
    \end{center}
    \vskip 0.3cm

    \hnu@authorization\par
    \vskip 1cm

    作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日

    导师签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
}

% 摘要、关键字
\newenvironment{abstract}{%
    \hnu@chapter{\hnu@abstractname}%
    % \addcontentsline{toc}{chapter}{\hnu@abstractname}
    \setcounter{page}{1}
  }{}
\newenvironment{enabstract}{%
    \hnu@chapter[Abstract]{\hnu@enabstractname}
    % \addcontentsline{toc}{chapter}{\hnu@enabstractname}
  }{}

\newenvironment{summary}{%
    \hnu@chapter{\hnu@summaryname}%
    \addcontentsline{toc}{chapter}{\hnu@summaryname}
}{}
\newenvironment{acknowledgements}{%
  \chapter{\hnu@acknowledgementsname}%
  % \addcontentsline{toc}{chapter}{\hnu@acknowledgementsname}
}{}

\newenvironment{committee}{%
  \chapter{\hnu@committeename}%
}{}

\newcommand\keywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=4\ccwd\relax%
  \sffamily\textbf{关键词}：#1}
\newcommand\enkeywords[1]{%
  \par\phantom{empty}\par\vspace{-1.1em}\noindent\hangindent=\baselineskip\relax%   %todo
  \textbf{Key Words: #1}}

% 目录
\renewcommand\tableofcontents{%
    \clearpage%
    \setcounter{tocdepth}{2}
    \hnu@chapter{\hnu@tocname}%
    \@starttoc{toc}
}

\RequirePackage{titletoc}
% from https://tex.stackexchange.com/questions/784/how-to-change-the-line-spacing-in-my-list-of-figures
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}
\newcommand\hnu@leaders{\titlerule*[0.5pc]{$\cdot$}}
  \titlecontents{chapter}[0bp]
    {\addvspace{6bp}\bf\sffamily\setfontsize{12.5pt}[15pt]}
    {\contentspush{\thecontentslabel\unskip\hskip\ccwd\relax}}
    {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\normalfont{\contentspage}}
  \titlecontents{section}
      [2\ccwd]
      {\setfontsize{12.5pt}[20pt]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\normalfont{\contentspage}}
  \titlecontents{subsection}
      [4\ccwd]
      {\setfontsize{12.5pt}[20pt]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\normalfont{\contentspage}}

  \titlecontents{figure}[0bp]
      {\setfontsize{12.5pt}}
      {\figureautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\hnu@leaders\contentspage}
  \titlecontents{table}[0bp]
      {\setfontsize{12.5pt}}
      {\tableautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\hnu@leaders\contentspage}


\newenvironment{notation}{%
    \cleardoublepage
    \thispagestyle{hnu@notation}
    \ctexset{chapter/format = \centering\rmfamily\setfontsize{12bp}}
    \hnu@chapter{\hnu@notationname}
    \setfontsize{10.5bp}[16bp]
    \setlength{\itemsep}{0bp}}{}
\newdimen\bp@ \bp@=1bp

\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{20\bp@}%
  \abovedisplayskip 12\bp@ \@plus3\bp@ \@minus7\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
  \renewcommand\small{%
     \@setfontsize\small{10.5\bp@}{17.5\bp@}%
     \abovedisplayskip 10.5\bp@ \@plus3\bp@ \@minus6\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini
                 \topsep 9\bp@ \@plus3\bp@ \@minus5\bp@
                 \parsep 4.5\bp@ \@plus2\bp@ \@minus\bp@
                 \itemsep \parsep}%
     \belowdisplayskip \abovedisplayskip
  }
  \renewcommand\footnotesize{%
     \@setfontsize\footnotesize{9\bp@}{15\bp@}
     \abovedisplayskip 9\bp@ \@plus2\bp@ \@minus5\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6\bp@ \@plus3\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini
                 \topsep 6\bp@ \@plus2\bp@ \@minus2\bp@
                 \parsep 3\bp@ \@plus2\bp@ \@minus\bp@
                 \itemsep \parsep}%
     \belowdisplayskip \abovedisplayskip
  }
  \renewcommand\scriptsize{\@setfontsize\scriptsize{7.5\bp@}{12.5\bp@}}
  \renewcommand\tiny{\@setfontsize\tiny{6.5\bp@}{10.83\bp@}}
  \renewcommand\large{\@setfontsize\large{15\bp@}{25\bp@}}
  \renewcommand\Large{\@setfontsize\Large{18\bp@}{30\bp@}}
  \renewcommand\LARGE{\@setfontsize\LARGE{22\bp@}{36.67\bp@}}
  \renewcommand\huge{\@setfontsize\huge{24\bp@}{40\bp@}}
  \renewcommand\Huge{\@setfontsize\Huge{26\bp@}{43.33\bp@}}

% 排版风格，标题，图表
\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{\z@}
\RequirePackage{upgreek}
\renewcommand\pi{\uppi}
\RequirePackage{amssymb}
\renewcommand\le{\leqslant}
\renewcommand\leq{\leqslant}
\renewcommand\ge{\geqslant}
\renewcommand\geq{\geqslant}
\DeclareMathSizes{10.5bp}{10.5bp}{7.35bp}{5.25bp}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.65}
\renewcommand\textfraction{.15}
\renewcommand{\floatpagefraction}{.6}
\RequirePackage{caption}
\RequirePackage{calc}
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
\captionsetup{
    format = hang,
    font = {small,bf},
    labelsep = zhspace,
}
\setlength{\textfloatsep}{6pt}
\setlength{\floatsep}{6pt}
\setlength{\intextsep}{6pt}
\captionsetup[figure]{
    position = bottom,
    aboveskip = 6bp,
    belowskip = {6bp-\intextsep},
}
\captionsetup[table]{
    position = top,
    aboveskip = 6bp,
    belowskip = 6bp,
}

\newcommand\note[1]{%
    \captionsetup{position = bottom, font = small}
    \caption*{\hangindent=2\ccwd\relax\hnu@notesname\rmfamily#1}}
\renewcommand{\thefootnote}{\hnu@textcircled{footnote}}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.25\textwidth
  \kern2.6\p@}
\renewcommand\@makefntext[1]{%
  \parindent 2\ccwd%
  \noindent
  \hb@xt@2\ccwd{\hss\@makefnmark}#1}
\RequirePackage[sort&compress]{natbib}
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
\def\tmp@numerical{numerical}
\def\tmp@authoryear{authoryear}
\newcommand\hnubibstyle[1]{%
  \def\tmp@gbt{#1}%
  \ifx\tmp@gbt\tmp@numerical%
    \bibliographystyle{hnunumerical}%
  \fi%
}

\if@hnu@numerical
  \if@hnu@super
    \citestyle{super}
  \else
    \citestyle{numbers}
  \fi
  \bibliographystyle{hnunumerical}%
\else
  \citestyle{authoryear}
  \bibliographystyle{hnuauthoryear}%
\fi

% 引用
\patchcmd\NAT@citexnum{%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\NAT@cmt#2\fi
  }{}%
  \NAT@mbox{\NAT@@close}%
}{%
  \NAT@mbox{\NAT@@close}%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\textsuperscript{#2}\fi
  }{}%
}{}{}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa
\if*#2*\else#2\NAT@spacechar\fi
\unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
   \else #1\fi\endgroup}
\renewcommand\NAT@citenum%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\patchcmd{\NAT@citex}{%
  \if*#2*\else\NAT@cmt#2\fi
  \if\relax\NAT@date\relax\else\NAT@@close\fi
}{%
  \if\relax\NAT@date\relax\else\NAT@@close\fi
  \if*#2*\else\textsuperscript{#2}\fi
}{}{}
\renewcommand\NAT@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\renewcommand\bibfont{\setfontsize{12bp}[20bp]}
\setlength{\bibsep}{0bp}
\setlength{\bibhang}{2\ccwd}
\renewcommand\@biblabel[1]{[#1]\hfill}
\urlstyle{same}
\g@addto@macro\UrlBreaks{%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
  \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
  \do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J%
  \do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T%
  \do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0%
}
\renewcommand\bibsection{%
    \@mainmatterfalse
    \chapter{\bibname}%
    \@mainmattertrue
}

% 数学符号：
\RequirePackage{amsmath,amsthm}
\makeatletter
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{16pt}
  \setlength\belowdisplayskip{16pt}
  \setlength\abovedisplayshortskip{16pt}
  \setlength\belowdisplayshortskip{16pt}
}
% \newcommand\eu{\mathrm{e}}
% \newcommand\iu{\mathrm{i}}
%\newcommand*{\diff}{\mathop{}\!\mathrm{d}}
%\DeclareMathOperator*{\argmax}{arg\,max}
%\DeclareMathOperator*{\argmin}{arg\,min}
% 数学定理：
% 以下定义数学定理环境默认风格为 hnuplain。
\newtheoremstyle{hnuplain}%
    {}{}%
    {}{2\ccwd}%
    {\bfseries}{}%
    {\ccwd}{}
\theoremstyle{hnuplain}
% 定义新的定理

\newcommand\hnu@assertionname{断言}
\newcommand\hnu@axiomname{公理}
\newcommand\hnu@corollaryname{推论}
\newcommand\hnu@definitionname{定义}
\newcommand\hnu@examplename{例}
\newcommand\hnu@lemmaname{引理}
\newcommand\hnu@proofname{证明}
\newcommand\hnu@propositionname{命题}
\newcommand\hnu@remarkname{注}
\newcommand\hnu@theoremname{定理}
\newtheorem{theorem}                {\hnu@theoremname}     [chapter]
\newtheorem{assertion}  [theorem]   {\hnu@assertionname}
\newtheorem{axiom}      [theorem]   {\hnu@axiomname}
\newtheorem{corollary}  [theorem]   {\hnu@corollaryname}
\newtheorem{lemma}      [theorem]   {\hnu@lemmaname}
\newtheorem{proposition}[theorem]   {\hnu@propositionname}
\newtheorem{definition}             {\hnu@definitionname}  [chapter]
\newtheorem{example}                {\hnu@examplename}     [chapter]
\newtheorem*{remark}                {\hnu@remarkname}
% \pkg{amsthm} 单独定义了 proof 环境，这里重新定义以满足格式要求。
% 原本模仿 \pkg{amsthm} 写成 |\item[\hskip\labelsep\hskip2\ccwd #1\hskip\ccwd]|，
% 但是却会多出一些间隙。
\renewenvironment{proof}[1][\proofname]{\par
    \pushQED{\qed}%
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
        \item\relax\hskip2\ccwd
        \textbf{#1}
        \hskip\ccwd\ignorespaces
    }{%
    \popQED\endtrivlist\@endpefalse
}
\renewcommand\proofname\hnu@proofname

% 算法和代码：
% 算法环境
\RequirePackage[algoruled, algochapter, lined, linesnumbered]{algorithm2e}
\renewcommand{\algorithmcfname}{算法}

\RequirePackage{listings}
\lstset{
    basicstyle=\small\ttfamily,
    xleftmargin=2pc,
    xrightmargin=2pc,
    frame=single,
    columns=flexible,
    numbers=left,
}
\newcommand{\rememberlines}{\xdef\rememberedlines{\number\value{AlgoLine}}}
\newcommand{\resumenumbering}{\setcounter{AlgoLine}{\rememberedlines}}

\RequirePackage[skins]{tcolorbox}
\newtcolorbox{talgorithm}[2][]{%
  blanker,float=tbp,grow to left by=#2,grow to right by=#2,
  before upper={\begin{algorithm}[htbp]},
  after upper={\end{algorithm}},
  #1
}

\newlist{achievements}{enumerate}{1}
\setlist[achievements]{
  topsep     = 6bp,
  partopsep  = 0bp,
  itemsep    = 6bp,
  parsep     = 0bp,
  leftmargin = 10mm,
  itemindent = 0pt,
  align      = left,
  label      = [\arabic*],
  resume     = achievements,
}
