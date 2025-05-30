local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local c = ls.choice_node
-- local t = ls.text_node
-- local s = ls.snippet
-- local i = ls.insert_node
-- local f = ls.function_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local sn = ls.snippet_node

local M = { snips = {}, autosnips = {} }

-- helper function to get list of snippets
local getSnippetsList = function(tbl)
  local snipList = {}
  for _, v in pairs(tbl) do
    table.insert(snipList, v)
  end
  return snipList
end

-- snippets

M.snips.bb = p({
  trig = "bb",
  name = "Bold Text \\textbf{|}",
  dscr = "Surrounds with bold text",
}, "\\\\textbf{$TM_SELECTED_TEXT$1}")

M.snips.it = p({
  trig = "it",
  name = "Italized Text \\textit{|}",
  dscr = "Surrounds with italized text",
}, "\\\\textit{$TM_SELECTED_TEXT$1}")

M.snips.m = p({
  trig = "m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.snips.M = p({
  trig = "M",
  name = "Math $$|$$",
  dscr = "Surrounds with double math symbols",
}, "\\$\\$$TM_SELECTED_TEXT$1\\$\\$")

M.snips.bu = p({
  trig = "bu",
  name = "Blank Underline $$_____$$",
  dscr = "Adds a blank underline for mcqs questions",
}, "\\underline{\\phantom{mmmmm}}")

M.snips.p = p({
  trig = "p",
  name = "Phantom",
  dscr = "Phantom in Latex notation",
}, "\\phantom{.}")

M.snips.v = p({
  trig = "v",
  name = "Vertical space",
  dscr = "Vertical space in Latex notation",
}, "\\vspace{${1:1}cm}")

M.snips.ta = p(
  {
    trig = "ta",
    name = "Assignment Template",
    dscr = "Assignment Template",
  },
  [[
\documentclass[11pt,a4paper]{article}
\usepackage[margin=3.5cm, vmargin={3cm,3cm}]{geometry}
\usepackage{amsmath}
\usepackage{multirow}

\title{Chapter ${1:02} - Practice Problems}
\author{${2:FIN335} - Dr. Ivan Duran }
\date{}

\begin{document}

\maketitle

\begin{enumerate}

  \item $3

\end{enumerate}

\end{document}
]]
)

M.snips.e = p({
  trig = "e",
  name = "Environment",
  dscr = "Latex Environment",
}, "\\begin{$1}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.snips.q = p(
  {
    trig = "q",
    name = "MCQ",
    dscr = "MCQ",
  },
  [[
\item $1
\alfa
$2
\myend
]]
)

M.snips.c = p({
  trig = "c",
  name = "Multicol Environment",
  dscr = "Multicol Environment",
}, "\\vspace*{-\\baselineskip}\n\\vspace*{1.2ex}\n\\begin{multicols}{2}\n$TM_SELECTED_TEXT$2\n\\end{multicols}")

M.autosnips.p = p({
  trig = ";p",
  name = "Phantom",
  dscr = "Phantom in Latex notation",
}, "\\phantom{.}")

M.autosnips.v = p({
  trig = ";v",
  name = "Vertical space",
  dscr = "Vertical space in Latex notation",
}, "\\vspace{${1:1}cm}")

M.snips.t10 = p(
  {
    trig = "t10",
    name = "Exam table 10",
    dscr = "Exam table with 10 MCQs",
  },
  [[
\begin{center}
  {\fontsize{10}{20}\selectfont
    \begin{tabular}{|c|c|c|c|c|}
      \hline
      \rowcolor{gray!15}
      \textbf{1}   & \textbf{2}   & \textbf{3}   & \textbf{4}   & \textbf{5}   \\\\\hline
      \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
      \rowcolor{gray!15}
      \textbf{6}   & \textbf{7}   & \textbf{8}   & \textbf{9}  & \textbf{10}   \\\\\hline
      \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
    \end{tabular}
  }
\end{center}
]]
)

M.snips.t20 = p(
  {
    trig = "t20",
    name = "Exam table 20",
    dscr = "Exam table with 20 MCQs",
  },
  [[
\begin{center}
  {\fontsize{10}{20}\selectfont
  \begin{tabular}{|c|c|c|c|c|c|c|c|c|c|}
    \hline
    \rowcolor{gray!15}
    \textbf{1} & \textbf{2} & \textbf{3} & \textbf{4}  & \textbf{5} & \textbf{6} & \textbf{7} & \textbf{8} & \textbf{9} & \textbf{10} \\\\\hline
    \hspace{1cm} & \hspace{1cm} & \hspace{1cm} &  \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
    \rowcolor{gray!15}
    \textbf{11}  & \textbf{12}  & \textbf{13}  & \textbf{14}   & \textbf{15}  & \textbf{16}  & \textbf{17}  & \textbf{18}  & \textbf{19}  & \textbf{20}  \\\\\hline
    \hspace{1cm} & \hspace{1cm} & \hspace{1cm} &  \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
  \end{tabular}
  }
\end{center}
]]
)

M.snips.ex = p(
  {
    trig = "ex",
    name = "Exams Template",
    dscr = "Major Exam Template",
  },
  [[
\documentclass[10pt,a4paper]{mydoc_eng}
\usepackage[margin=2cm, vmargin={2cm,1cm},includefoot]{geometry}
\renewcommand{\baselinestretch}{1.1}
\setlength{\parindent}{0pt}
\setlength{\headheight}{14.5pt}
\usepackage{paralist}
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{multicol}
\usepackage{array}
% For long underlines use ulem's \uline instead
\usepackage{ulem}
\usepackage{booktabs}
%%%Headers and Footers%%%
\usepackage{fancyhdr}
\pagestyle{fancy}
\chead{}
\rhead{${1:MAJOR} EXAM ${2:I }- ${3:ECON102}}
\cfoot{\thepage}
\rfoot{Prince Sultan University}
\lfoot{${4:Oct. 05, 2024}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
%%%%%%%%%%%%%%%%%

\newcommand{\blank}{\line(1,0){60}\;}

% Define a new column type that centers the content within a specified width
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

\begin{document}
\title{$1 EXAM $2- $3 (${5:FALL 2024})}
\author{}
\maketitle

\textbf{I. (${6:6} marks) Multiple Choice Questions.} Write your answers to the MCQs in the table below:

\phantom{.}

\begin{center}
  {\fontsize{10}{20}\selectfont
    \begin{tabular}{|c|c|c|c|c|c|}
      \hline
      \rowcolor{gray!15}
      \textbf{1}   & \textbf{2}   & \textbf{3}   & \textbf{4}   & \textbf{5}   & \textbf{6}   \\\\\hline
      \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
      \rowcolor{gray!15}
      \textbf{7}   & \textbf{8}   & \textbf{9}   & \textbf{10}  & \textbf{11}  & \textbf{12}  \\\\\hline
      \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} & \hspace{1cm} \\\\\hline
    \end{tabular}
  }
\end{center}

\phantom{.}

\begin{enumerate}[1.]

  \item Main statement
  \alfa
  \item item
  \item item
  \item item
  \item item
  \myend

  \item Multicolumn question
  \alfa
  \vspace*{-\baselineskip}
  \vspace*{1.2ex}
  \begin{multicols}{2}
  \item item.     \item item.
  \item item.     \item item.
  \end{multicols}
  \myend

\end{enumerate}

\rule{\textwidth}{0.4pt}

\textbf{II. (${7:9} marks) Numerical and Analytical Questions.}

\center\textbf{INSTRUCTIONS}

\begin{itemize}
  \item In all your calculations, use at least \textbf{4 decimals} for intermediate results, and \textbf{2 decimals} for final answers.
  \item Only use the space provided to answer your questions. \textbf{No additional paper will be provided}, so think and plan your answer before attempting to writing it down.
  \item Using pencil is allowed to write your answers.
  \item \textbf{Be clear and organized!}
\end{itemize}

\rule{\textwidth}{0.4pt}

\begin{enumerate}[Q1.]
  \item (5 marks)

  \newpage

  \item (5 marks)

  \newpage

  \item (4 marks)

\end{enumerate}
\end{document}
]]
)

-- autosnippets

M.autosnips.bb = p({
  trig = ";bb",
  name = "Bold Text \\textbf{|}",
  dscr = "Surrounds with bold text",
}, "\\\\textbf{$TM_SELECTED_TEXT$1}")

M.autosnips.it = p({
  trig = ";it",
  name = "Italized Text \\textit{|}",
  dscr = "Surrounds with italized text",
}, "\\\\textit{$TM_SELECTED_TEXT$1}")

M.autosnips.m = p({
  trig = ";m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.autosnips.M = p({
  trig = ";M",
  name = "Math $$|$$",
  dscr = "Surrounds with double math symbols",
}, "\\$\\$$TM_SELECTED_TEXT$1\\$\\$")

M.autosnips.bu = p({
  trig = ";bu",
  name = "Blank Underline $$_____$$",
  dscr = "Adds a blank underline for mcqs questions",
}, "\\underline{\\phantom{mmmmm}}")

M.autosnips.e = p({
  trig = ";e",
  name = "Environment",
  dscr = "Latex Environment",
}, "\\begin{$1}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.autosnips.c = p({
  trig = ";c",
  name = "Multicol Environment",
  dscr = "Multicol Environment",
}, "\\vspace*{-\\baselineskip}\n\\vspace*{1.2ex}\n\\begin{multicols}{2}\n$TM_SELECTED_TEXT$2\n\\end{multicols}")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
