%
% tfinvoice.cls
%
% Simple invoices with built-in calculation.
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Identification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{tfinvoice}[2015/01/25]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Requirements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Class options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptions\relax
\PassOptionsToClass{}{scrlttr2}

\LoadClass{scrlttr2}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Required packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[orthodox,l2tabu]{nag}

\RequirePackage{fltpoint}
\RequirePackage{graphicx}
\RequirePackage{lmodern}
\RequirePackage{numprint}
\RequirePackage{soul}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newkomavar{logo}

\newkomavar{fromphonelabel}
\newkomavar{fromfaxlabel}

\newkomavar{customernumberlabel}
\newkomavar{customernumber}
\newkomavar{invoicenumberlabel}
\newkomavar{invoicenumber}
\newkomavar{datelabel}

\newkomavar{positionlabel}
\newkomavar{descriptionlabel}
\newkomavar{singlepricelabel}
\newkomavar{quantitylabel}
\newkomavar{subtotallabel}
\newkomavar{currency}
\newkomavar{totallabel}

\newkomavar{beforeclosing}
\newkomavar{closing}

\newkomavar{bankaccountlabel}
\newkomavar{bankaccount}
\newkomavar{taxidnumberlabel}
\newkomavar{taxidnumber}

\newkomavar{pagelabel}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\logo}[1]{%
	\setkomavar{logo}{#1}%
	\edef\x{%
		\lowercase{%
			\def\noexpand\logo{#1}%
		}%
	}%
	\x%
}

\renewcommand*\familydefault{\sfdefault}

\newcounter{itemnr}
\setcounter{itemnr}{0}
\newcommand*{\curposition}{0}
\newcommand*{\invoicesum}{0}
\newcommand{\newitem}[3]{%
\stepcounter{itemnr}%
\fpMul{\curposition}{#2}{#3}%
\global\let\curposition\curposition%
\fpAdd{\invoicesum}{\invoicesum}{\curposition}%
\global\let\invoicesum\invoicesum%
\\%
\arabic{itemnr} & {#1} & \numprint{#2} & \numprint{#3} & \numprint{\curposition}\\%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{invoicelist}{%
\opening{}%
\begin{center}%
\begin{tabular}{cp{75mm}rrr}%
\textbf{\usekomavar{positionlabel}} & \textbf{\usekomavar{descriptionlabel}} & \textbf{\usekomavar{singlepricelabel}} & \textbf{\usekomavar{quantitylabel}} & \textbf{\usekomavar{subtotallabel}}\\%
& & \usekomavar{currency} & & \usekomavar{currency}\\%
\hline%
}{%
\\%
\hline%
\\%
& & \multicolumn{2}{r}{\textbf{\usekomavar{totallabel}}} & \textbf{\numprint{\invoicesum} \usekomavar{currency}}\\%
\\%
\cline{3-5}%
\end{tabular}%
\end{center}%
\vspace*{1.5em}%
\usekomavar{beforeclosing}%
\closing{\usekomavar{closing}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\KOMAoptions{parskip=half*}

\LoadLetterOption{options}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Document information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setkomavar{backaddressseparator}{~\textbf{$\cdot$}~}
\setkomavar{backaddress}{%
	\makebox[0pt][l]{%
		\underline{%
			\makebox[\useplength{firstheadwidth}][l]{%
				\tiny\usekomavar{fromname}\\\usekomavar{fromaddress}%
			}%
		}%
	}%
}

\addtokomafont{subject}{\Large}

\@setplength{sigindent}{0pt}

\@setplength{firstheadvpos}{7,8mm}

\@newplength{infocolwidth}
\@setplength{infocolwidth}{6cm}

\setkomavar{firsthead}{%
	\fontsize{8}{12}\sffamily
	\parbox[t][30mm][c]{\textwidth}{
		\centering
		\ifkomavarempty{logo}{}{\includegraphics[width=.96\textwidth,height=30mm,keepaspectratio]{\logo}}
	}\\
	\mbox{}\hfill
	\begin{picture}(0,0)
	\put(0,0){%
		\begin{minipage}[t]{\useplength{infocolwidth}}
		\vspace{17,71mm}
		~\\
		\parbox{\useplength{infocolwidth}}{
			{\usekomafont{fromname}\usekomavar{fromname}\\}
			{\usekomafont{fromaddress}\usekomavar{fromaddress}\\}
			\mbox{}
		}\\
		\parbox{\useplength{infocolwidth}}{
			\ifkomavarempty{fromphone}{}{\usekomafont{fromaddress}\parbox{3mm}{\usekomavar{fromphonelabel}}\usekomavar{fromphone}\\}
			\ifkomavarempty{fromfax}{}{\usekomafont{fromaddress}\parbox{3mm}{\usekomavar{fromfaxlabel}}\usekomavar{fromfax}\\}
			\mbox{}
		}\\
		\parbox{\useplength{infocolwidth}}{
			\normalsize
			\mbox{}\\
			\ifkomavarempty{customernumber}{}{\parbox{35mm}{\usekomavar{customernumberlabel}}\usekomavar{customernumber}\\}
			\ifkomavarempty{invoicenumber}{}{\parbox{35mm}{\usekomavar{invoicenumberlabel}}\usekomavar{invoicenumber}\\}
			\ifkomavarempty{date}{}{\parbox{35mm}{\usekomavar{datelabel}}\usekomavar{date}\\}
			\mbox{}
		}
		\end{minipage}
	}
	\end{picture}
	\hspace*{\useplength{infocolwidth}}
}

\l@addto@macro\@firstheadfootfield{\setkomavar{date}{}}

\setkomavar{nexthead}{}

\@setplength{firstheadwidth}{\textwidth}
\@setplength{firstfootwidth}{\textwidth}

\@setplength{fromrulewidth}{\textwidth}

\@setplength{toaddrhpos}{\oddsidemargin}
\@addtoplength{toaddrhpos}{1in}

\@setplength{firstfootvpos}{\paperheight}
\@addtoplength{firstfootvpos}{-2cm}

\setkomavar{firstfoot}{%
	\centering
	\footnotesize
	\rule{\textwidth}{.4pt}\\
	\usekomavar{fromname}
	\textbf{$\cdot$}
	{\def\\{~\textbf{$\cdot$}~}\usekomavar{fromaddress}}
	\textbf{$\cdot$}
	\usekomavar{fromphonelabel}~\usekomavar{fromphone}
	\textbf{$\cdot$}
	\usekomavar{fromfaxlabel}~\usekomavar{fromfax}\\
	\usekomavar{bankaccountlabel}~{\def\\{~\textbf{$\cdot$}~}\usekomavar{bankaccount}}
	\textbf{$\cdot$}
	\usekomavar{taxidnumberlabel}~\usekomavar{taxidnumber}
}

\setkomavar{nextfoot}{
	\normalfont
	\footnotesize
	\usekomavar{subject} \usekomavar{invoicenumber} \hfill \usekomavar{pagelabel} \thepage
}

\pagestyle{headings}

\let\raggedsignature\raggedright

\setul{1pt}{.4pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
