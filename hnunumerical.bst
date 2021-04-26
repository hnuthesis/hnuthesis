%% hnuthesis.bst
%%
%% 湖南大学学位论文参考文献 BibTeX 样式  

FUNCTION {is.print.banners.to.terminal} { #1 }

%%%%%%%%%%%%%%%%
% 版本与提示信息
%%%%%%%%%%%%%%%%
% 版本信息
FUNCTION{bst.file.version} { "0.1" }
FUNCTION{bst.file.date} { "2017/08/19" }
FUNCTION{bst.file.website} { 
  "https://github.com/chengchang/hnuthesis" }

% 开始提示信息
FUNCTION {banner.message}{ 
is.print.banners.to.terminal
    { "-- HNUTThesis.bst version" " " * bst.file.version *
      " (" * bst.file.date * ") " * "by Cheng Chang." *
       top$
       "-- " bst.file.website *
       top$
       "-- See the " quote$ * "userguide.pdf" * quote$ * 
       " manual for usage information." *
       "[2021.4] modified by yusanshi <meet.leiyu@gmail.com>" *
       top$
    }
    { skip$ }
  if$
}

% 完成提示信息
FUNCTION {completed.message} { 
is.print.banners.to.terminal
    { "" top$ "Done." top$ }
    { skip$ }
  if$
}

ENTRY
  { address
    author
    booktitle
    chapter
	day
    edition
    editor
	translator
    howpublished
    institution
    journal
    key
    lang
    month
    note
    number
    organization
    pages
	nationality
	patenttype
	patentnumber
    publisher
    school
    series
    title
    type
    volume
    year
    url
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.year}
{ 't :=
  number empty$
  volume empty$
  and
    { add.period$ write$ }
    { ", " * write$ }
  if$
  t
}

STRINGS {z}
FUNCTION {remove.dots}
{ 'z :=
  ""
  { z empty$ not}
  { z #1 #1 substring$
    z #2 global.max$ substring$ 'z :=
    duplicate$ "." = 'pop$
      { * }
    if$
  }
  while$
  z
}

FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}

FUNCTION {format.note}
{
 note empty$
    { "" }
    { note #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$
        }
      if$
      note #2 global.max$ substring$ * "note" bibinfo.check
    }
  if$
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ duplicate$ empty$
    'pop$
    'write$
  if$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
    'skip$
    { after.sentence 'output.state := }
      if$
    }
  if$
}


FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {bbl.etal}
{ "et~al" }

FUNCTION {bbl.cn.etal}
{ "等" }

FUNCTION {format.lang}
{ lang empty$
    'skip$
    'skip$
  if$
 }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
	"{vv}{ll}{jj}{ f{~}}"
     format.name$
      %bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {
          nameptr #3
          #1 + =
          numnames #3
          > and
		  %> ,
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            { numnames #2 >
              { "" * }
              'skip$
              if$
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {
                  lang empty$
                   { ", " * bbl.etal * }
                    { lang "zh" =
                       { ", " * bbl.cn.etal * }
                       'skip$
                      if$
                    }
                  if$
                }
                {
                  lang empty$
                    { ", " * t * }
                    { lang "zh" =
                       { ", " * t * }
                       'skip$                   
                     if$
                    }
                  if$
                } 
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {editors.names}
{ lang empty$
    { ", (eds.)" }
    { ", 编" }
  if$
}


FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
     editors.names *
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
        { "--" *
          t #2 global.max$ substring$ 't :=
        }
        {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
          while$
        }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
    { "" }
    { "there's a month but no year in " cite$ * warning$
      month
    }
      if$
    }
    { month empty$
    'year
    { year "-" * month *}
      if$
    }
  if$
}

FUNCTION {date}
{ day empty$
    { "there's a year and month but no day in " cite$ * warning$
      format.date
    }
	{ format.date "-" * day *
	}
	if$
 }

FUNCTION {format.btitle}
{ title %emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
    'skip$
    { " of " * series * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
    { series field.or.null }
    { output.state mid.sentence =
        { "number" }
        { "Number" }
      if$
      number tie.or.space.connect
      series empty$
        { "there's a number but no series in " cite$ * warning$ }
        { " in " * series * }
      if$
    }
      if$
    }
    { "" }
  if$
}
%%专利国别，类型，专利号%%%
FUNCTION {format.nationality}
{ nationality empty$
{"The nationality in " cite$ * " is missing." * warning$}
{nationality }
if$
}

FUNCTION {format.patenttype}
{ patenttype empty$
  {""}
  {patenttype}
		if$
		}
		
FUNCTION {format.patentnumber}
{ patenttype empty$
  {"The number in " cite$ * " is missing." * warning$}
  {patentnumber}
		if$
		}
		
%%版次%%%%
FUNCTION {format.edition}
{ edition empty$
    { "" }
    {edition}
      if$
 }


FUNCTION {format.url}
{ url empty$
    { "" }
    { new.block " {\url{" url * "}}" * }
  if$
}


INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}
% 译者格式
FUNCTION {format.translators}
{ translator empty$
   { "" }			% 无译者
   { new.block			% 有译者
      translator format.names "译" *
    }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
    { "" pages n.dashify tie.or.space.connect }
    { "" pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
    { "there's a number but no volume in " cite$ * warning$ }
    'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
    { pop$ format.pages }
    { ":" * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    { "" }
    { type empty$
      { "chapter" }
      { type "l" change.case$ }
    if$
    chapter tie.or.space.connect
    pages empty$
      'skip$
      { ", " * format.pages * }
    if$
    }
  if$
}

FUNCTION {collection.in}
{ lang empty$
    { "In: " }
    { "见: " }
  if$
}
FUNCTION {collection.in.cn}
{ lang empty$
    { "In: " }
    { "见: " booktitle *}
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
    { lang empty$
        { collection.in "Proc of " * booktitle * }
        { collection.in.cn "会议论文集" *}
      if$
    }
    { lang empty$
        { collection.in format.editors * ". Proc of " * booktitle * }
        { collection.in format.editors * ". " * booktitle * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
    { "need key or journal for " cite$ * " to crossref " * crossref *
      warning$
      ""
    }
    { "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{ll }{f{~}}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
    'skip$
    { editor #2 "{ll }{f{~}}" format.name$ "others" =
        { " et~al." * }
        { " and " * editor #2 "{ll }{f{~}}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { series empty$
        { "need editor, key, or series for " cite$ * " to crossref " *
          crossref * warning$
          "" *
        }
        { "{\em " * series * "\/}" * }
      if$
    }
    { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { booktitle empty$
        { "need editor, key, or booktitle for " cite$ * " to crossref " *
          crossref * warning$
          ""
        }
        { "In {\em " booktitle * "\/}" * }
      if$
    }
    { "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}
%%%%%出版地和出版者的格式设置%%%%%%%%%%%%%%
FUNCTION {format.address.publisher}
{ address empty$
    { publisher empty$
    { "" }
    { "there's a publisher but no address in " cite$ * warning$
      publisher
    }
      if$
    }
    { publisher empty$
    'address
    { address ": " * publisher * }
      if$
    }
  if$
}
%%%%%地址和学校的格式设置%%%%%%%%%%%%%%
FUNCTION {format.address.school}
{ address empty$
    { school empty$
    { "" }
    { "there's a school but no address in " cite$ * warning$
      school
    }
      if$
    }
    { school empty$
    'address
    { address ": " * school * }
      if$
    }
  if$
}



FUNCTION {format.title.type}
{ title empty$
    { type empty$
        { "" }
        { "there's a type but no title in " cite$ * warning$
          type
        }
      if$
    }
    { type empty$
        'title
        { title ": " * type * }
      if$
    }
  if$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%以下为参考文献中各类文献所需的条目内容（其中有output.check的表示不能为空）%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%出版物（为有确定出版社的书籍）%%
FUNCTION {book} 
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  format.title "" * "title" output.check
  format.translators output
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      %new.sentence
      %format.address.publisher output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  new.block
  format.address.publisher output
  pages empty$
    { format.date "year" output.check 
      % new.sentence
      % format.pages output
    }
    { format.date ":" * format.pages * output }
  if$  
  fin.entry
}

%%期刊%%
FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "" * "title" output.check
  new.block
  crossref missing$
    { %journal emphasize "journal" output.check
      journal "journal" output.check
      %format.date "year" output.check
      %new.block
      year output
      format.vol.num.pages output.year
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.note output  
  fin.entry
}
%%为印制的有封皮的作品，但没有出版社或赞助机构的名称（多见于会议的自制论文集）%%
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title "" * "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  fin.entry
}
%%为一本书的一部分(章，节或某些页)（几乎不用该条目）%%
FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "" * "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      %format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  pages empty$
    { format.date output }
    { format.date ":" * format.pages * output }
  if$
  % format.date "." * format.pages * output
  fin.entry
}

%%为一本书中有自己题目的一部分（几乎不用该条目）%%
FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "" * "title" output.check
  new.block
  crossref missing$
    { 
    format.in.ed.booktitle "booktitle" output.check
      %format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      format.address.publisher output
      %address output
      %publisher "publisher" output.check
      %format.edition output
      % format.date "year" output.check
      % format.date ". " * format.pages * output
      format.date ":" * format.pages * output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  % new.block
  % note output
  fin.entry
}
%%为会议论文集中的一篇文章%%
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "." * "title" output.check
  crossref missing$
    { 
	  new.block
	  format.in.ed.booktitle  "booktitle" output.check
      format.bvolume output
      %format.number.series output
      %format.pages output
	  new.block
      address empty$
    { organization publisher new.sentence.checkb
      organization output
      publisher output
      %format.date "year" output.check
      year output
    }
    { %address output.nonnull
      format.address.publisher output  
      %format.date "year" output.check
      year output
      %new.sentence
      organization output
      %publisher output
    }
      if$
      format.pages output
      %remove.dots
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.note output  
  fin.entry
}

FUNCTION {cnproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "." * "title" output.check
  new.block
  format.in.ed.booktitle  "booktitle" output.check
  new.block
  format.address.publisher output  
  year output
  %new.sentence
  organization output
  %new.block
  format.pages output
  %remove.dots
  new.block
  format.note output  
  fin.entry
  %remove.dots
}

%%为会议论文集中的一篇文章%%
FUNCTION {conference} { inproceedings }

%%为科技文档%%
FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
    'skip$
    { organization output.nonnull
      address output
    }
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
    { address new.block.checka
      address output
    }
    'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  fin.entry
}
%%硕士学位论文格式%%
FUNCTION{format.masters}
{
lang empty$
{"Thesis]"}
{school "硕士学位论文]" *}
if$
}
FUNCTION{format.masters.title}
{title empty$
{""}
{title ":  [" * format.masters *}
if$
}
FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" add.period$ output.check
  new.block
  format.masters.title "" * "title" output.check
  new.block
  format.address.school output
  %format.madd "address" output.check
  %school "school" output.check  
  format.date "year" output.check
  format.pages output
  new.block
  note output
  fin.entry
}

%%博士学位论文%%
FUNCTION{format.phd}
{
lang empty$
{"Dissertation]"}
{school "博士学位论文]" *}
if$
}
FUNCTION{format.phd.title}
{title empty$
{""}
{title ":  [" * format.phd *}
if$
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" add.period$ output.check
  new.block
  %format.title remove.dots ": " * phdthesis.type * output
  format.phd.title "" * "title" output.check
  new.block
  format.address.school output
  %address output
  %school "school" output.check  
  format.date "year" output.check
  format.pages output
  new.block
  note output
  fin.entry
}
%不属于其它任何类型的作品%
FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title "" * "title" output.check
  howpublished new.block.checka
  howpublished output
  format.date output
  format.url output
  new.block
  note output
  fin.entry
  empty.misc.check
}

%%会议论文集（几乎不用该条目）%%
FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "" * "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
    { publisher new.sentence.checka }
    { organization publisher new.sentence.checkb
      organization output
    }
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
    'skip$
    { organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}
%%技术报告%%
FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "" * "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  date "year" output.check
  format.url output
  new.block
  note output
  fin.entry
}
%%%%%%%%%%%%%%%%%%%%%
%% 著录格式: 电子文献
%%%%%%%%%%%%%%%%%%%%%
FUNCTION {electronic} {
 output.bibitem
  
 author empty$
    { organization "author and organization" output.check }
    { format.authors output.nonnull }
  if$
  format.title "" * "title" output.check
  format.url output
  date output.nonnull
  note output

  fin.entry
}

%%%%%%%%%%%%%%%%%%%%%
%% 著录格式: 报刊杂志
%%%%%%%%%%%%%%%%%%%%%
FUNCTION {magazine} {
 output.bibitem
 format.authors "author" output.check
 new.block
 format.title "" * "title" output.check
 new.block
 publisher output
 date output
 note output

  fin.entry
}


%%%%%%%%%%%%%%%%%
%% 著录格式: 专利
%%%%%%%%%%%%%%%%%
FUNCTION {patent} {
  output.bibitem
  format.authors "author" output.check
  new.block
  format.title "" * "title" output.check
  new.block
  format.nationality "" * "nationality" output.check
  new.block
  format.patenttype "" * "patenttype" output.check
  format.patentnumber "" * "patentnumber" output.check
  new.block
  date output
  note output
  format.note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "" * "title" output.check
  new.block
  note "note" output.check
  format.date output
  fin.entry
}

FUNCTION {default.type} {article}

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

READ

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}
%%主程序%%
EXECUTE {banner.message}	      % 显示初始提示信息
EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
EXECUTE {completed.message}	      % 显示完成提示信息
