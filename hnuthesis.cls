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

%% 判断是否为 pdf，pdf 则单面%
\if@hnu@pdf
  \PassOptionsToClass{oneside}{book}
\fi

%% 关闭 fontspec 的数字处理
\PassOptionsToPackage{no-math}{fontspec}

%% 表示当前是继承类，在这个上面拓展， utf8 编码支持，a4 纸张，允许章节在任何页开始(latex 默认双面打印，章节从奇数开始)，设置文档默认字号为小四（12pt）%
\LoadClass[UTF8, a4paper, openany, zihao=-4]{ctexbook}[2015/05/14]

%% 兼容性检查
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
%% 字体设置
% \setmainfont{Times New Roman} % 正文西文字体（衬线体）
% \setsansfont{Times New Roman} % 无衬线字体（标题等）
% \setmonofont{Times New Roman} % 等宽字体（代码、公式）

\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

% 此处主要是模板不能带有商业化字体，正式使用请自己上传字体，并将此处改为：注释部分。详情见：https://github.com/hnuthesis/hnuthesis/blob/72506418e6a8ceb6e0db2e8435ee93a5183d3e44/hnuthesis.cls#L38
%\RequirePackage[UTF8]{ctex}     % 引入 ctex 宏包
% \setCJKmainfont{Noto Serif CJK SC} % 设置宋体为正文字体
% \setCJKsansfont{Noto Serif CJK SC}
\setCJKmainfont{[simsun.ttc]}[AutoFakeBold=true]  % 正文中文字体：宋体（伪粗体）AutoFakeBold，字体缺失粗体，自动生成伪粗体
\setCJKsansfont{[simhei.ttf]} % 无衬线中文字体：黑体

%% pdf 文件的一些信息设置
\RequirePackage{hyperref}
\hypersetup{
    bookmarksopen=true, % 默认展开书签目录
    bookmarksnumbered=true, % 书签显示章节编号
    bookmarksopenlevel=1, % 展开到 1 级标题
    CJKbookmarks=true, % 支持中文书签（避免乱码）
    pdfborder=0 0 0, %  超链接无边框（默认有彩色框）
    unicode=true, % 允许 Unicode 字符
    linktoc=all, % 目录中的所有都可以点击
}
\if@hnu@pdf
    \hypersetup{
        colorlinks=true, % 超链文字显示为彩色
        allcolors=blue, % 所有超链接设置为蓝色
    }
\fi

% pdf 元数据，右键查看文件信息可以看到
\AtBeginDocument{
    \hypersetup{
        pdftitle={\hnu@title}, % 标题
        pdfauthor={\hnu@author} % 作者
    }
}

%% xparse 可以提供一些命令自定义功能
\RequirePackage{xparse}
% 定义新命令：setfontsize 位置 1 为必选参数，2 为可选参数
% \setfontsize{12pt}          % 字号12pt，行距24pt
% \setfontsize{12pt}[18pt]    % 字号12pt，行距18pt
\NewDocumentCommand\setfontsize{mo}{
    \IfValueTF{#2}{ % 检查第二个参数是否存在（行距）
        \fontsize{#1}{#2} %  存在则设置字号为#1，行距为#2
    }{ % 不存在，行距默认为 2 倍字号
        \fontsize{#1}{2\dimexpr#1}
    }
    \linespread{1}\selectfont\relax}  % 确保行距缩放因子为 1


% 定义新命令：zhspace ，生成给予中文字宽的间距按中文全角字符宽度（\ccwd）生成水平间距。
% \zhspace    % 默认 1 个中文字宽（≈1em）
% \zhspace[2] % 2 个中文字宽
\newcommand\zhspace[1][1]{\hspace{#1\ccwd}}

% 定义新命名：hnu@underline，固定宽度下划线, #1 下划线宽度默认为 6em，
% \hnu@underline{张三}       % 宽度6em，显示 "张三" 下方有下划线
% \hnu@underline[8em]{导师}  % 宽度8em，显示 "导师" 下方有下划线
\newcommand\hnu@underline[2][6em]{%
    \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt\relax
}

%% 定义\hnu@define@term 宏，定义元数据变量
% \hnu@define@term{title} % 定义 \title 命令
% 等效于：
% \gdef\title#1{\gdef\hnu@title{#1}}
% \title{} % 初始化
\def\hnu@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{ % 定义全局命令
        \expandafter\gdef\csname hnu@#1\endcsname{##1} % 存储到内部宏
    }
    \csname #1\endcsname{} % 初始化命令
}
\hnu@define@term{hnucode}
\hnu@define@term{hnuname}
\hnu@define@term{title}
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
\hnu@define@term{cultivation}
\hnu@define@term{specialty}
\hnu@define@term{chair}
\hnu@define@term{entitle}
\hnu@define@term{enauthor}
\hnu@define@term{enmajor}
\hnu@define@term{endoctor}
\hnu@define@term{enmaster}
\hnu@define@term{enbachelor}
\hnu@define@term{enhnuname}
\hnu@define@term{ensupervisor}
\hnu@define@term{endate}

%% 定义内部命令
\if@hnu@doctor
  \newcommand\hnu@thesisname{博/硕士学位论文}%
\fi

%% 表格：
% 提供学术论文中的三线表
\RequirePackage{booktabs}
% 跨行合并单元格
\RequirePackage{multirow}
% 跨页表格
% \RequirePackage{longtable}



% 题注、标题
\renewcommand\listfigurename{插图索引}
\renewcommand\listtablename{附表索引}
\newcommand\hnu@notesname{\textbf{注}：}
\newcommand\hnu@enabstractname{Abstract}
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

%% 页面设置
\RequirePackage{geometry}
\geometry{
    paper=a4paper, % 设置纸张
    top=2.5cm, % 上边距
    bottom=2.5cm, % 下边距
    left=3cm, % 左边距
    right=3cm, % 右边距 
    headheight=1cm, % 页眉高度
    headsep=1cm, % 页眉间距（页眉底部到正文顶部的距离）
    footskip=1.1cm % 页脚基准（页脚底部距离页面底部的距离）
}


%% 页眉页脚定制工具
\RequirePackage{fancyhdr}
% todo 考虑删除
% \renewcommand{\headrulewidth}{0.4pt}
% 定义页面样式
\fancypagestyle{hnu@headings}{%
  \fancyhf{}% % 清空默认页眉页脚内容
  \fancyhead[CE]{\setfontsize{9pt}\hnu@title} % 偶数页显示论文标题
  \fancyhead[CO]{\setfontsize{9pt}\hnu@thesisname} % 奇数页显示论文类型
  \fancyfoot[C]{\setfontsize{9pt}\thepage} % 页脚居中显示页码
  \fancyheadoffset[LO,LE]{3mm} % 左侧页页眉内容向右偏移 3mm
  \fancyheadoffset[RO,RE]{-3mm} % 右侧页页眉内容向左偏移 3mm
  \makeatletter
  \def\headrule{ % 自定义页眉线为双横线
    \if@fancyplain\let\headrulewidth\plainheadrulewidth\fi%
    \hrule\@height 1.0pt \@width\headwidth\vskip 1pt %上面线为1pt粗
    \hrule\@height 0.5pt \@width\headwidth  %下面0.5pt粗
    \vskip-2\headrulewidth\vskip-1pt}      %两条线的距离1pt
    \vspace{7mm} % 页眉线和正文之间相差7mm 间距
}

% 定义符号说明页面，隐藏页脚
\fancypagestyle{hnu@notation}{\fancyfoot{}}
% 全局默认使用页眉页脚样式
\pagestyle{hnu@headings}

%% 章节标题优化
\patchcmd\chaptermark{#1}{\protect\spacetitle{#1}}{}{}

%% 章节起始规则：在双面打印的模式下，强制新章节从奇数页开始
% 若文档为双栏排版（twocolum），确保空白页处理
\renewcommand*{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\g@addto@macro\frontmatter{%
  \pagenumbering{Roman}% % 大罗马数字
}

% 正文部分
\renewcommand\mainmatter{%
  \cleardoublepage % 强制从奇数页开始
  \pagenumbering{arabic} % 阿拉伯数字
  \@mainmattertrue % 标记从正文开始
}

%% 基于enumitem 实现列表（有序、无序）
\RequirePackage{enumitem}

% 无序
\setitemize{
    leftmargin=3em, % 列表整体左侧缩进 3em（约 3 个中文字宽）
    itemsep=0em, % 列表项之间的垂直间距为 0
    partopsep=0em,  % 列表与段落上下文的间距为 0
    parsep=0em, % 列表项内部段落间距为 0
    topsep=-0em % 列表顶部与上文间距为 0（负号可能为排版优化）
}

% 有序
\setenumerate{
    leftmargin=3em,
    itemsep=0em,
    partopsep=0em, 
    parsep=0em,
    topsep=0em 
}

%% 章节、段落、页眉、页脚
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi % 章节起始规则：若文档为双面打印模式。新章节强制奇数页开始，单面则换新页面
  \setlength{\baselineskip}{20pt} % 章节标题后正文行距为20pt
  \renewcommand{\CJKglue}{\hskip 0.5pt plus \baselineskip} % 中文字符间距优化
  \global\@topnum\z@ % 浮动体位置控制（图标）z@表示禁止
  \@afterindenttrue % 段落首行缩进
  \secdef\@chapter\@schapter %区分带编号和不带编号的章节
}

%% 脚注
% 加载pifont 提供符号字体
\RequirePackage{pifont}
% 定义宏
\def\hnu@textcircled#1{%
  \ifnum\value{#1} >9 % 检查参数#1是否大于9，直接报错
    \ClassError{hnuthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ding{\the\numexpr\value{#1}+191\relax} % 生成带圈的数字
}

%% 动态计算标题长度，动态调整中文字符间距。
\RequirePackage{stringstrings} % 加载宏，计算字符串长度
\newcounter{titlelength} % 计数器
\newcommand\spacetitle[1]{%
  \@getstringlength{#1}{titlelength}% %计算标题#1的长度，存入
  \ifnum\thetitlelength=2{\ziju{2}#1}\else% % 若标题为2 应用字距为 2调整间距
    \ifnum\thetitlelength=3{\ziju{1}#1}\else%
      \ifnum\thetitlelength=4{\ziju{0.5}#1}\else#1%
      \fi
    \fi
  \fi
}

%% 章节信息设置
% 设置章节编号深度到五级，默认为 3
\setcounter{secnumdepth}{5}
\ctexset{
    % 章格式
    chapter = {
        format      = \centering\sffamily\bfseries\setfontsize{18pt}, % 居中、无衬线体，加粗、18pt
        nameformat  = {}, % 标题添加额外内容，默认为第 xx 章
        % titleformat = \spacetitle,
        number      = \thechapter, % 编号为阿拉伯数字
        aftername   = \hspace{\ccwd}, % 编号后1 个中文字符间隔
        beforeskip  = -1.5em, % 24bp - 31bp标题前间距
        afterskip   = 1.5em, % 18bp - 10bp 标题后间距
        % fixskip   = true, % will be used in future version
    },
    % 节格式
    section = {
        format     = \bf\sffamily\setfontsize{15pt}, % 加粗无衬线体，15pt
        aftername  = \hspace{\ccwd}, % 编号后 1 空中文字符
        beforeskip = 12pt, 
        afterskip  = 12pt,
    },
    % 小节格式
    subsection = {
        format     = \bf\sffamily\setfontsize{14pt},
        aftername  = \hspace{\ccwd},
        % indent     = 2\ccwd,
        beforeskip = 6pt,
        afterskip  = 6pt,
    },
    % 子小节
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

% 定义一个自定义章节的命令
% 无序章节\hnu@chapter{摘\quad 要}
% pdf标签 \pdfbookmark[0]{标题}{hnuchapter.编号}
% 同步页眉标题 \chaptermark{标题}
\newcounter{hnu@pdfbookmark}
\NewDocumentCommand\hnu@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \addtocounter{hnu@pdfbookmark}\@ne
  \IfValueTF{#1}{%
    \pdfbookmark[0]{#1}{hnuchapter.\thehnu@pdfbookmark}%
    \chaptermark{#1}%
  }{%
    \pdfbookmark[0]{#2}{hnuchapter.\thehnu@pdfbookmark}%
    \chaptermark{#2}%
  }%
  \chapter*{#2}
}

% 封面格式设置
\renewcommand\maketitle{%
    \newgeometry{
        top=3.8cm, bottom=3.8cm,
        left=3.2cm, right=3.2cm,
        headheight=0cm, headsep=0.8cm,
        footskip=0.8cm}
    \pagenumbering{gobble} % 禁用页码
    \pdfbookmark[0]{封面}{titlepage} % pdf 书签封面
    \make@cntitle % 中文封面
    \pdfbookmark[0]{Title page}{entitlepage} % 英文书签
    \make@entitle % 英文封面
    \restoregeometry % 恢复排版
    \pdfbookmark[0]{原创性声明}{statement} % pdf 书签
    \make@statement %原创声明
}

% 定义宏：\hnu@supervisorline
% \hnu@ensupervisor{Prof. John Smith}       % 主导师英文名
% \hnu@encosupervisor{Dr. Emily Brown}      % 副导师英文名（可选）
\newcommand\hnu@supervisorline{%
  \ifx\hnu@encosupervisor\@empty% % 检查副导师是否为空
    Supervisor: \hnu@ensupervisor%
  \else%
    Supervisors: \hnu@ensupervisor, \hnu@encosupervisor%
  \fi
}

% 定义宏：\vpostext
\RequirePackage{tikz} % 加载绘图宏包
\newcommand\vpostext[2]{% 定义命名，接受 2 个参数
  \tikz[remember picture,overlay]% 启动 tikz 绘图，不占用页面布局空间
      \node [yshift=-#1]% 节点垂直向下偏移 #1
        at (current page.north)% 定位到页面顶部中央
        [below,align=flush center]%节点锚点在下方，文本居中对齐
          {\parbox{\textwidth}{\centering#2}};% 创建等宽文本框，内容居中
}

% 定义新命令linetext 3 个参数
% #1 文本行宽度 #2 文本的对齐方式（l, r, c 左中右） #3 实际显示的文本内容
\newcommand\linetext[3]{%
  \underline{\makebox[#1][#2]{#3}}
}

\newcommand{\multilinefield}[3]{%
  \linetext{#3}{l}{%
    \makebox[#1][s]{\sffamily\textbf{#2}}%
    \hspace{\qquad}%
    \begin{tabular}[t]{@{}l@{}}%
}

\newcommand{\endmultilinefield}{%
    \end{tabular}%
  }%
}


% 中文封面
\RequirePackage{tabularx} % 引入表格拓展包，支持自动调整列宽
\newcommand\make@cntitle{%定义生成中文封面的命令
  \begin{titlepage}% 开始封面页配置
    % 使用 tikz绝对定位，从页面左上角，偏移（2.5cm, -2.5cm）
     \tikz[remember picture,overlay]%
        \node [xshift=2.5cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {% 左对齐

          \newlength{\@tw} % 定义新长度变量用于存储标签宽度
          \setlength{\@tw}{55pt}% 设置标签宽度为 55pt
          \newlength{\@cw}% 定义新长度变量用于存储内容框宽度
          \setlength{\@cw}{3.2cm}% 设置内容框宽度为 3.2cm

          \setfontsize{12.5pt}};%

      % 处置定位校徽（距离页面顶部 5cm）
      \vpostext{5cm}{\includegraphics[height=3.0734cm]{figures/hnu_logo.png}}%
      % 显示论文类型（距顶部 12cm，22pt 加粗无衬线字体）
      \vpostext{9.5cm}{\bf\sffamily\setfontsize{22pt}\hnu@thesisname}%
      % 显示论文标题（距顶部 15cm， 26pt加粗无衬线字体）
      \vpostext{13.5cm}{\bf\sffamily\setfontsize{26pt}\hnu@title}%

      % 定位作者信息（距左5cm 顶部 20cm）
      \tikz[remember picture,overlay]
        \node [xshift=5cm,yshift=-20cm] at (current page.north west)%
            [below right,align=left] {%
          \setlength{\@tw}{94pt}%设置标签宽度 94pt
          \setlength{\@cw}{6.4cm}% 设置内容宽度为 6.4cm

          \setfontsize{12.5pt}%设置字体大小

          % 创造作者信息表格（左对齐）
          \begin{tabular}{@{}l@{\hspace{\ccwd}}l@{}}%@{}去除间距，\ccwd 为汉字宽度
            {\makebox[\@tw][s]{\sffamily\textbf{作者姓名}}\qquad\hnu@author} \\%
            {\makebox[\@tw][s]{\sffamily\textbf{指导教师}}\qquad\hnu@supervisor} \\%
            {\makebox[\@tw][s]\qquad{\qquad\hnu@cosupervisor}} \\
            {\makebox[\@tw][s]{\sffamily\textbf{培养单位}}\qquad\hnu@cultivation} \\%
            {\makebox[\@tw][s]{\sffamily\textbf{学科专业}}\qquad\hnu@major} \\%
            {\makebox[\@tw][s]{\sffamily\textbf{研究方向}}\qquad\hnu@workon} \\%
          \end{tabular}};%

      \clearpage
      \thispagestyle{empty}

      % 设置顶部信息
      \tikz[remember picture,overlay]
        \node [xshift=5cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {%

          \setlength{\@tw}{66.5pt}
          \setlength{\@cw}{3.2cm}

          \setfontsize{12pt}%
          % 简单表格布局
          \begin{tabularx}{\linewidth}{ll}%
            \makebox[\@tw][s]{\sffamily\textbf{学校代码}} & \linetext{\@cw}{l}{\hnu@hnucode} \\
            \makebox[\@tw][s]{\sffamily\textbf{学号}} & \linetext{\@cw}{l}{\hnu@authorid} \\
            \makebox[\@tw][s]{\sffamily\textbf{密级}} & \linetext{\@cw}{l}{\hnu@secrettext}
          \end{tabularx}};%
      % 学校名称和论文类型（距左5.4cm 顶部 8cm）
      \tikz[remember picture,overlay]
        \node [xshift=5.4cm,yshift=-8cm] at (current page.north west)%
            [below right,align=left]%
            {\parbox{\textwidth}{\setfontsize{18pt}\hnu@hnuname\hnu@thesisname}};
      % 论文标题（距左5.4cm 顶部 12cm）
      \tikz[remember picture,overlay]
        \node [xshift=5.4cm,yshift=-12cm] at (current page.north west)%
            [below right,align=left]%
            {\parbox{12cm}{\bf\sffamily\setfontsize{22pt}\hnu@title}};
      
      % 扩展表格信息（距左5.4cm 顶部 12cm）
      \tikz[remember picture,overlay]
        \node [xshift=5.2cm,yshift=-18cm] at (current page.north west)%
            [below right,align=left] {%
          \setlength{\@tw}{107pt}
          \setlength{\@cw}{9.5cm}

          \setfontsize{12.5pt}%
          \begin{tabular}{@{}l}%单列布局
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{作者姓名：}}\qquad\hnu@author} \\%
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{指导教师：}}\qquad\hnu@supervisor} \\
            {\makebox[\@tw][s]\qquad\linetext{5.75cm}{l}{\qquad\hnu@cosupervisor}} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{培养单位：}}\qquad\hnu@cultivation} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{专业类别：}}\qquad\hnu@major} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{专业领域：}}\qquad\hnu@specialty} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{论文提交日：}}\qquad\hnu@submitdate} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{论文答辩日：}}\qquad\hnu@defensedate} \\
            \linetext{\@cw}{l}{\makebox[\@tw][s]{\sffamily\textbf{答辩委员会主席：}}\qquad\hnu@chair}
          \end{tabular}};%
    \end{titlepage}
}

% 英文封面
\newcommand\make@entitle{%
    \begin{titlepage}%封面页环境
        % 主标题（距顶部 3.9cm 15pt）
        \vpostext{5cm}{\setfontsize{15pt}\text{\hnu@entitle}}%
        
        % 作者信息区块
        \vpostext{6.5cm}{\setfontsize{12pt}\text{by}}%
        \vpostext{7.5cm}{\setfontsize{12pt}\text{\hnu@enauthor}}%
        \vpostext{8.5cm}{\setfontsize{12pt}\text{\hnu@enbachelor}}%
        % \vpostext{9.5cm}{\setfontsize{12.5pt}\hnu@enmaster}%
        % 学位声明
        \vpostext{9.5cm}{\setfontsize{12pt}\text{A thesis submitted in partial satisfaction of the}}%
        \vpostext{10.5cm}{\setfontsize{12pt}\text{requirements for the degree of}}%
        \vpostext{11.5cm}{\setfontsize{12pt}\text{\hnu@endoctor}}%
        \vpostext{12.5cm}{\setfontsize{12pt}\text{in}}%
        \vpostext{13.5cm}{\setfontsize{12pt}\text{\hnu@enmajor}}%
        \vpostext{14.5cm}{\setfontsize{12pt}\text{in the}}%
        \vpostext{15.5cm}{\setfontsize{12pt}\text{Graduate School}}%
        \vpostext{16.5cm}{\setfontsize{12pt}\text{of}}%
        \vpostext{17.5cm}{\setfontsize{12pt}\text{\hnu@enhnuname}}%

        % 底部信息
        \vpostext{18.5cm}{\setfontsize{12pt}\text{Supervisor}}%
        \vpostext{19.5cm}{\setfontsize{12pt}\text{\hnu@ensupervisor}}%
        \vpostext{20.5cm}{\setfontsize{12pt}\text{\hnu@endate}}%
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

%% 原创声明配置
\newcommand\make@statement{
    \thispagestyle{empty}% 无页眉、页码配置
    \pagenumbering{Roman}% 页码设置
    \setcounter{page}{1}% 重置页码为 1
    \setfontsize{12pt}[20pt]% 字体设置（字号 12.5pt， 行距20pt）
    \vspace*{-0.15cm}% 向上微调 0.15cm
    % 原创声明标题
    \begin{center}
      \sffamily% 无衬线字体
      \setfontsize{18pt}% 大号字体
      \makebox[3.5cm][s]{\textbf\hnu@hnuname}\\% 学校名称（两段对齐）
      \textbf{学位论文原创性声明}% 主标题
    \end{center}
    \vskip 0cm% 标题下方间距

    \hnu@declaretext\par% 声明正文
    % 签名区域
    \vskip 1cm
    作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
    \vskip 1cm
    % 版权申明
    \begin{center}
      \sffamily
      \setfontsize{18pt}\textbf{学位论文版权使用授权书}
    \end{center}
    \vskip 0.3cm

    \hnu@authorization\par
    \vskip 1cm

    作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
    
    导师签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
    \restoregeometry
}

% 摘要、
\newenvironment{abstract}{%
    \hnu@chapter{\hnu@abstractname}%
    \addcontentsline{toc}{chapter}{\hnu@abstractname}
    \setcounter{page}{1}
  }{}
\newenvironment{enabstract}{%
    \begingroup
        \ctexset{chapter/format=\centering\rmfamily\bfseries\setfontsize{18pt}}%
        \hnu@chapter[Abstract]{\hnu@enabstractname}
    \endgroup
    \addcontentsline{toc}{chapter}{\hnu@enabstractname}
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

%% 定义关键字命令
\newcommand\keywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=4\ccwd\relax%
  \sffamily\textbf{关键词}：#1}
\newcommand\enkeywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=5.3em\relax%
  \textbf{Key Words}: #1}

%% 目录
\renewcommand\tableofcontents{%
    \clearpage%强制换页，确保目录从新页开始
    \setcounter{tocdepth}{2}% 设置目录的深度为 sub
    % \addcontentsline{toc}{chapter}{\hnu@tocname}
    \hnu@chapter{\hnu@tocname}%使用自定义章节样式显示目录标题
    \@starttoc{toc}% 实际生成目录内容
}

%% 设置目录格式
\RequirePackage{titletoc}
\newcommand\hnu@leaders{\titlerule*[0.5pc]{$\cdot$}}% 定义点线格式
  \titlecontents{chapter}[0bp]% 章条目 0缩进
    {\addvspace{6bp}\bf\sffamily\setfontsize{12.5pt}[15pt]}% 段前 6bp 间距，黑体加粗
    {\contentspush{\thecontentslabel\unskip\hskip\ccwd\relax}}% 标签后加 1 汉子宽度
    {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}% 点线+页码
  \titlecontents{section}% 节条目格式
      [2\ccwd]% 缩进 2 个汉字宽度
      {\setfontsize{12.5pt}[20pt]}% 字号、间距
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}
  \titlecontents{subsection}% 小节条目
      [4\ccwd]
      {\setfontsize{12.5pt}[20pt]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}

  \titlecontents{figure}[0bp]% 图目录样式
      {\setfontsize{12.5pt}}
      {\figureautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\hnu@leaders\contentspage}
  \titlecontents{table}[0bp]% 表目录样式
      {\setfontsize{12.5pt}}
      {\tableautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\hnu@leaders\contentspage}

% 为了让图目录另页起，重新定义 \cs{listoffigures}
\renewcommand\listoffigures{%
    \clearpage
    \hnu@chapter{\listfigurename}%
    \addcontentsline{toc}{chapter}{\listfigurename}
    \@starttoc{lof}}
    % 表目录同样
\renewcommand\listoftables{%
    \clearpage
    \hnu@chapter{\listtablename}%
    \addcontentsline{toc}{chapter}{\listtablename}
    \@starttoc{lot}}

%% 定义一个环境，排版文档中的符号说明和术语表
\newenvironment{notation}{%
    \cleardoublepage% 强制新页开始
    \thispagestyle{hnu@notation}% 自定义页面风格
    \ctexset{chapter/format = \centering\rmfamily\setfontsize{12bp}}% 章节标题居中 + 罗马字体 + 12bp 字号
    \hnu@chapter{\hnu@notationname}% 生成无编号章节
    \setfontsize{10.5bp}[16bp]% 正文字号、行距
    \setlength{\itemsep}{0bp}}{}% 列表项间距为 0
\newdimen\bp@ \bp@=1bp% 定义长度单位基准

% 重新定义正文默认尺寸
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{20\bp@}%字号 12bp 行距 20bp
  \abovedisplayskip 12\bp@ \@plus3\bp@ \@minus7\bp@% 公式上方间距 12bp（+-3-7bp）
  \abovedisplayshortskip \z@ \@plus3\bp@% 短公式上方间距（可拉升）
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@ % 短公式下方间距
  \belowdisplayskip \abovedisplayskip% 公式下方间距与上方相同
  \let\@listi\@listI}% 重置列表项间距为默认值


\normalsize
% 小号字体
  \renewcommand\small{%
     \@setfontsize\small{10.5\bp@}{17.5\bp@}%
     \abovedisplayskip 10.5\bp@ \@plus3\bp@ \@minus6\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini% 列表项间距
                 \topsep 9\bp@ \@plus3\bp@ \@minus5\bp@
                 \parsep 4.5\bp@ \@plus2\bp@ \@minus\bp@
                 \itemsep \parsep}%
     \belowdisplayskip \abovedisplayskip
  }
  % 脚注字号
  \renewcommand\footnotesize{%
     \@setfontsize\footnotesize{9\bp@}{15\bp@}
     \abovedisplayskip 9\bp@ \@plus2\bp@ \@minus5\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6\bp@ \@plus3\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini
                 \topsep 6\bp@ \@plus2\bp@ \@minus2\bp@% 列表顶部与上下文的间距
                 \parsep 3\bp@ \@plus2\bp@ \@minus\bp@% 列表项内段落间距
                 \itemsep \parsep}%% 列表项之间的间距
     \belowdisplayskip \abovedisplayskip
  }
  % 图表中的极小标注
  \renewcommand\scriptsize{\@setfontsize\scriptsize{7.5\bp@}{12.5\bp@}}
  \renewcommand\tiny{\@setfontsize\tiny{6.5\bp@}{10.83\bp@}}
  \renewcommand\large{\@setfontsize\large{15\bp@}{25\bp@}}
  \renewcommand\Large{\@setfontsize\Large{18\bp@}{30\bp@}}
  \renewcommand\LARGE{\@setfontsize\LARGE{22\bp@}{36.67\bp@}}
  \renewcommand\huge{\@setfontsize\huge{24\bp@}{40\bp@}}
  \renewcommand\Huge{\@setfontsize\Huge{26\bp@}{43.33\bp@}}

% 排版风格，标题，图表
\setlength{\parindent}{2\ccwd}% 段落首行缩进 2 个汉字宽度
\setlength{\parskip}{\z@}% 段落间距设置为 0
\RequirePackage{upgreek}% 加载直立希腊字母包
\renewcommand\pi{\uppi}% 将 π 设为直立形式（默认斜体）

% 替换手写体
\RequirePackage{amssymb}
\renewcommand\le{\leqslant}
\renewcommand\leq{\leqslant}
\renewcommand\ge{\geqslant}
\renewcommand\geq{\geqslant}
% 定义数学符号尺寸
\DeclareMathSizes{10.5bp}{10.5bp}{7.35bp}{5.25bp}

% 控制页面中浮动体（图表）的比例
\renewcommand{\topfraction}{.85}% 页面顶部最多容纳85%的浮动体
\renewcommand{\bottomfraction}{.65}% 页面底部最多容纳65%
\renewcommand\textfraction{.15}% 文本区域至少占15%
\renewcommand{\floatpagefraction}{.6}% 浮动页至少60%内容为浮动体

\RequirePackage{caption}% 加载图表标题定制包
\RequirePackage{calc}% 支持长度计算
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}% 定义中文分隔符

% 全局标题设置
\captionsetup{
    format = hang,%设置悬挂缩进
    font = {small,bf},% 使用较小字号
    labelsep = zhspace,%汉字宽度
}
% 图格式设置
\captionsetup[figure]{
    position = bottom,% 标题位置为图下方
    aboveskip = 6bp,
    belowskip = {12bp-\intextsep},
}
% 表格设置
\captionsetup[table]{
    position = top,
    aboveskip = 6bp,
    belowskip = 6bp,
}

%% 定义 note 命令，用于在文档中添加无编号的注释
\newcommand\note[1]{%
    \captionsetup{position = bottom, font = small}% 设置注释位于下方，字体为 small
    \caption*{\hangindent=2\ccwd\relax\hnu@notesname\rmfamily#1}}% 悬挂缩进 + 罗马字体
\renewcommand{\thefootnote}{\hnu@textcircled{footnote}}% 脚注标记改为圆圈数字

%% 脚注分割线
\renewcommand\footnoterule{%
  \kern-3\p@% 向上移动 3pt
  \hrule\@width.25\textwidth% 生成长度为页面 25% 宽度的水平线
  \kern2.6\p@}% 向下移动 2.6pt，调整脚注文本与分割线的距离

%% 脚注文本格式
\renewcommand\@makefntext[1]{%
  \parindent 2\ccwd%% 段落缩进 2 个汉子宽度
  \noindent
  \hb@xt@2\ccwd{\hss\@makefnmark}#1}% 将脚注标记放置在 2 个汉字宽度的盒子中右对齐

%% 加载宏包，支持更灵活的参考文献的格式，并对对引用进行排序和压缩[1,2,3]显示[1-3]
%% 并定义三种参考文献格式
\RequirePackage[sort&compress]{natbib}
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}% 上标数字
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}% 普通数字
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}} % 作者-年份格式

%% 根据用户选择的参考文献的格式，动态设置对应的参考的文献样式文件
\def\tmp@numerical{numerical}%临时宏
\def\tmp@authoryear{authoryear}

% 定义命令hnubibstyle，判断使用什么参考文件样式
\newcommand\hnubibstyle[1]{%
  \def\tmp@gbt{#1}%
  \ifx\tmp@gbt\tmp@numerical%
    \bibliographystyle{hnunumerical}%
  \fi%
}

%% 根据用户选择的参考文献的引用格式
\if@hnu@numerical % 是否启用数值引用
  \if@hnu@super% 嵌套判断是否使用上标数字
    \citestyle{super}% 上标引用（如 [¹,²]）
  \else
    \citestyle{numbers}% 普通数字引用（如 [1,2]）
  \fi
  \bibliographystyle{hnunumerical}% % 数值引用对应的参考文献样式
\else% 否则启用作者-年份格式
  \citestyle{authoryear}% 作者-年份引用（如 (Smith, 2020)）
  \bibliographystyle{hnuauthoryear}%% 对应的参考文献样式
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
%    
\renewcommand\bibfont{\normalfont\fontsize{12pt}{20pt}\selectfont}
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
  before upper={\begin{algorithm}[H]},
  after upper={\end{algorithm}},
  #1
}
