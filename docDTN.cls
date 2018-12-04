%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% $Id: docDTN.cls,v 1.0 2015/05/20 17:08:31 mb Exp $
%% $Author: rc $
%% $Date: 2016/09/27 $
%% $Revision: 1.0 $
%% $Name:  $
%% $State: Exp $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sur la base de :
%% Fichier  : docDTN.cls
%% Auteur   : Michel Belliard
%% Auteur   : Philippe Fillion
%% Auteur   : Fabrice Gaudier 
%% Creation : 20/02/2003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Identification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\fileversion{1.0}
\def\filedate{2016/09/26}
\def\docdate {2016/09/26}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{docDTN}[\filedate\space v\fileversion\space Document DTN]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Mode de compilation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@sPDF
\ifx\pdfoutput\undefined
  \dm@sPDFfalse                           %% mode : LaTeX
\else
  \ifnum \pdfoutput=0                     %% mode : LaTeX
    \dm@sPDFfalse
  \else
    \pdfoutput=1                          %% mode : PDFLaTeX
    \dm@sPDFtrue
  \fi
\fi 

%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables Globales
%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@ScoreAQ
\dm@s@ScoreAQ = \z@
\newcount\dm@s@MaxScoreAQ
\dm@s@MaxScoreAQ  = 8

%%%%%%%%%%%%%%%%%%%%%%
%% Relecteur/Verificateur
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@numberVerificateur
\dm@s@numberVerificateur = \z@

\def\dm@s@SetVerificateur@#1#2{%
  \ifcase\dm@s@numberVerificateur\or
  \def\dm@s@verificateurAName{#1} \def\dm@s@verificateurAFunction{#2} \def\dm@s@verificateurALabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire} \or
  \def\dm@s@verificateurAName{#1} \def\dm@s@verificateurAFunction{#2} \def\dm@s@verificateurALabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire} \or
  \def\dm@s@verificateurBName{#1} \def\dm@s@verificateurBFunction{#2} \def\dm@s@verificateurBLabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire} \fi
}


\def\dm@s@AddVerificateur#1#2{%
  \ifnum\dm@s@numberVerificateur = 0
    \global\advance\dm@s@ScoreAQ\@ne
  \fi
  \ifnum\dm@s@numberVerificateur < 3 %
    \global\advance\dm@s@numberVerificateur\@ne
    \dm@s@SetVerificateur@{#1}{#2}
  \else
    \PackageError{Classe docDTN}{ 2 'Verificateur' maximum}%
  \fi
}

%% API Utilisateur

 \def\setverificateur#1#2{%
   \dm@s@AddVerificateur{#1}{#2}}
 \def\addverificateur#1#2{%
   \dm@s@AddVerificateur{#1}{#2}}
 
 \def\setrelecteur#1{%
   \setverificateur{#1}{}}

%%%%%%%%%%%%%%%%%%%%%% 
%% Approbateur
%%%%%%%%%%%%%%%%%%%%%%
\def\setapprobateur#1#2{%
  \global\advance\dm@s@ScoreAQ\@ne
  \def\dm@s@approbateurName{#1}
  \def\dm@s@approbateurFunction{#2}}

%%%%%%%%%%%%%%%%%%%%%%
%% Autre Visa
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@NbVisa
\dm@s@NbVisa = \z@

\def\setvisa#1#2{%
  \ifnum\dm@s@NbVisa < 2 %
    \global\advance\dm@s@NbVisa\@ne
    \def\dm@s@visaName{#1}
    \def\dm@s@visaFunction{#2}
  \else
    \PackageError{Classe docDTN}{ 1 'Autre Visa' maximum}%
  \fi}

%%%%%%%%%%%%%%%%%%%%%%
%% Emetteur
%%%%%%%%%%%%%%%%%%%%%%
\def\setemetteur#1#2{%
  \global\advance\dm@s@ScoreAQ\@ne
  \def\dm@s@emetteurName{#1}
  \def\dm@s@emetteurFunction{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Option du document %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% List of figures
\newif\ifdm@s@haveListOfFigures
\dm@s@haveListOfFigurestrue
%% List of tables
\newif\ifdm@s@haveListOfTables
\dm@s@haveListOfTablestrue
%% Timbre (Restreinte, Confidentiel
\newif\ifdm@s@haveTimbre
\dm@s@haveTimbretrue
%% le document est-il date 
\newif\ifdm@s@haveNotDated
\dm@s@haveNotDatedtrue
%% Diffusion externe au DTN
\newif\ifdm@s@haveReferenceExterne
\dm@s@haveReferenceExternefalse
%% Contient un resume
\newif\ifdm@s@haveResume
\dm@s@haveResumefalse
%% Contient un numero chrono
\newif\ifdm@s@haveNumeroChrono
\dm@s@haveNumeroChronofalse
\def\dm@s@defaultNumeroChrono{XX-YYY}
%% Contient un resume DO 
\newif\ifdm@s@haveResumeDO
\dm@s@haveResumeDOfalse
%% Contient un resume anglais
\newif\ifdm@s@haveResumeAnglais
\dm@s@haveResumeAnglaisfalse
%% Niveau de Diffusion : Normale (default : true)
\newif\ifdm@s@DiffusionNormale
\dm@s@DiffusionNormaletrue
%% Niveau de Diffusion : Restreinte (default : false) 
\newif\ifdm@s@DiffusionRestreinte
\dm@s@DiffusionRestreintefalse
%% Niveau de Diffusion : CCEA (default : false) 
\newif\ifdm@s@DiffusionCCEA
\dm@s@DiffusionCCEAfalse
%% Niveau de Diffusion : CD (default : false) 
\newif\ifdm@s@DiffusionCD
\dm@s@DiffusionCDfalse
%% Niveau de Diffusion : SD (default : false) 
\newif\ifdm@s@DiffusionSD
\dm@s@DiffusionSDfalse
%% Contient les references de l'action (Partenaire/Accord/type)
\newif\ifdm@s@havereferenceaction
\dm@s@havereferenceactionfalse
%% Contient les informations  jalon
\newif\ifdm@s@haveJalon
\dm@s@haveJalonfalse
%% Contient le delai contractuel de Confidentialite
\newif\ifdm@s@haveDelaiConfidentialite
\dm@s@haveDelaiConfidentialitefalse
%% Contient un numero de Cahier de Laboratoire
\newif\ifdm@s@haveCahierLaboratoire
\dm@s@haveCahierLaboratoirefalse
%%
%% OLD
%%
\newif\ifdm@s@havenumeropublication
\dm@s@havenumeropublicationfalse
\newif\ifdm@s@h@veind@ce
\dm@s@h@veind@cefalse
\newif\ifdm@s@haveMotsClefs
\dm@s@haveMotsClefsfalse
\newif\ifdm@s@havedob
\dm@s@havedobfalse
\newif\ifdm@s@haveprojet
\dm@s@haveprojetfalse
\newif\ifdm@s@haveeotp
\dm@s@haveeotpfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Direction               %%
%%   nom complet           %%
%%   initiales             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setDirection#1#2{%
  \def\dm@s@direction{#1}
  \def\dm@s@abrDirection{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sous-Direction          %%
%%   nom complet           %%
%%   initiales             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@setSousDirection#1#2{%
  \def\dm@s@sousdirection{#1}
  \def\dm@s@abrSousDirection{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Departement             %%
%%   nom complet           %%
%%   initiales             %%
%%   CdD                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setDepartment#1#2#3{%
  \def\dm@s@departement{#1}
  \def\dm@s@abrDepartement{#2}
  \def\dm@s@CdD{#3}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Service                %%
%%   nom complet           %%
%%   initiales             %%
%%   CdS                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setService#1#2#3{%
  \def\dm@s@service{#1}
  \def\dm@s@abrService{#2}
  \def\dm@s@CdS{#3}
  \setemetteur{#3}{Chef de Service}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Laboratoire             %%
%%   nom complet           %%
%%   initiales             %%
%%   CdL                   %%
%%   Centre, Batiment, PC  %%
%%   Tel, Fax, Mail        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setlaboratoire#1#2#3#4#5#6#7#8#9{%
  \def\dm@s@laboratoire{#1}
  \def\dm@s@abrLaboratoire{#2}
  \setapprobateur{#3}{Chef de Laboratoire}
  \def\dm@s@laboratoireCentre{#4}
  \def\dm@s@laboratoireBatiment{#5}
  \def\dm@s@laboratoirePC{#6}
  \def\dm@s@laboratoireTel{#7}
  \def\dm@s@laboratoireFax{#8}
  \def\dm@s@laboratoireMail{#9}
}
\def\setemail#1{%
  \def\dm@s@laboratoireMail{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% langues                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ENGLISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifenglish
\DeclareOption{english}{

\PassOptionsToPackage{english}{babel}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NOMS DES INFORMATIONS ANGLAIS                        %%
%%   A maintenir par l'ingenieur Qualite du departement %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifdm@s@isderdir
\dm@s@isderdirfalse

\dm@s@setDirection{Nuclear Energy Division}{CEA/\-DEN}
\dm@s@setSousDirection{Cadarache Center}{CAD}
\dm@s@setDepartment{Nuclear Technology Department}{DTN}{\sc Christophe DELLIS}

\def\@smta{\dm@s@setService{Measurements and modelling of Transfers and Severe Accidents Section}{SMTA}{\sc Dominique PECHEUR}}
\def\@stcp{\dm@s@setService{Component Techology and Process Section}{STCP}{\sc Olivier GASTALDI}}

%%%%%%%%%%%%%%%
%%   SMTA
%%%%%%%%%%%%%%%

\DeclareOption{lmag}{%
  \dm@s@setlaboratoire{Severe Accident Modelling Laboratory}{LMAG}{\sc Laurent Saas}{Cadarache}{219}{}{48 23}{77 88}{smtalmag}
  \@smta}

%%%%%%%%%%%%%%%
%%   STCP
%%%%%%%%%%%%%%%

%% A faire...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NATURE DU DOCUMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{nt}{
  \dm@s@setTypeDocument{Technical Note}{NT}
  \dm@s@isNotetrue}

\DeclareOption{rt}{
  \dm@s@setTypeDocument{Technical Report}{RT}
  \dm@s@isRapporttrue}

\DeclareOption{st}{
  \dm@s@setTypeDocument{Technical Specification}{ST}
  \dm@s@isSpecificationtrue}

\DeclareOption{pu}{
  \dm@s@setTypeDocument{Publication}{PU}
  \dm@s@isPublicationtrue}

\def\dm@s@ReferenceAName{Reference}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUTEURS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@defaultFonctionAuteur{Researcher}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GESTION DES INDICES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@defaultNatureIndiceA{\sc First edition}
\def\dm@s@PagesModifieesB{\sc Entire document}
\def\dm@s@PagesModifieesC{\sc Entire document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF ENGLISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\englishtrue
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FRANCAIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{french}{

\PassOptionsToPackage{french}{babel}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NOMS DES INFORMATIONS FRANCAIS                       %%
%%   A maintenir par l'ingenieur Qualite du departement %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifdm@s@isderdir
\dm@s@isderdirfalse

\dm@s@setDirection{Direction de l'\'Energie Nucl\'eaire}{CEA/\-DEN}
\dm@s@setSousDirection{Centre de Cadarache}{CAD}
\dm@s@setDepartment{Departement de Technologie Nucl\'eaire}{DTN}{\sc Christophe DELLIS}

\def\@smta{\dm@s@setService{Service Mesures et mod\'elisation des Transferts et des Accidents graves}{SMTA}{\sc Dominique PECHEUR}}
\def\@stcp{\dm@s@setService{Service de Technologies des Composants et des Proc\'ed\'es}{STCP}{\sc Olivier GASTALDI}}

%%%%%%%%%%%%%%%
%%   SMTA
%%%%%%%%%%%%%%%

\DeclareOption{lmag}{%
  \dm@s@setlaboratoire{Laboratoire de Mod\'elisation des Accidents graves}{LMAG}{\sc Laurent Saas}{Cadarache}{219}{}{48 23}{77 88}{smtalmag}
  \@smta}

%%%%%%%%%%%%%%%
%%   STCP
%%%%%%%%%%%%%%%

%% A faire...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NATURE DU DOCUMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{nt}{
  \dm@s@setTypeDocument{Note Technique}{NT}
  \dm@s@isNotetrue}

\DeclareOption{rt}{
  \dm@s@setTypeDocument{Rapport Technique}{RT}
  \dm@s@isRapporttrue}

\DeclareOption{st}{
  \dm@s@setTypeDocument{Sp\'ecification}{ST}
  \dm@s@isSpecificationtrue}

\DeclareOption{pu}{
  \dm@s@setTypeDocument{PUBLICATION}{PU}
  \dm@s@isPublicationtrue}

\def\dm@s@ReferenceAName{R\'ef\'erence}
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUTEURS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@defaultFonctionAuteur{Ing\'enieur-Chercheur}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GESTION DES INDICES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@defaultNatureIndiceA{Emission initiale}
\def\dm@s@PagesModifieesB{Tout le document}
\def\dm@s@PagesModifieesC{Tout le document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIN DU FRANCAIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\englishfalse
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Nature du document          %%
%%  rt : Rapport Technique     %%
%%  st : Spefication technique %%
%%  nt : Note technique        %%
%%  pu : Publication           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setTypeDocument#1#2{%
  \def\dm@s@typeDocument{#1}%
  \def\dm@s@abrTypeDocument{#2}}

\newif\ifdm@s@isNote
\dm@s@isNotefalse
\newif\ifdm@s@isRapport
\dm@s@isRapportfalse
\newif\ifdm@s@isSpecification
\dm@s@isSpecificationfalse
\newif\ifdm@s@isPublication
\dm@s@isPublicationfalse


  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% mode de compilation            %%
%%   article ( valeur par defaut) %%
%%   report                       %%
%%   book                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isArticle
\dm@s@isArticletrue
\newif\ifdm@s@isReport
\dm@s@isReportfalse
\newif\ifdm@s@isBook
\dm@s@isBookfalse

\DeclareOption{article}{
  \dm@s@isArticletrue}

\DeclareOption{report}{
  \dm@s@isReporttrue
  \dm@s@isArticlefalse}

\DeclareOption{book}{
  \dm@s@isBooktrue
  \dm@s@isArticlefalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Etat "Projet" du doc    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isDraft
\dm@s@isDraftfalse

\ifdm@sPDF
  \PassOptionsToPackage{pdftex}{graphicx}
\else
  \PassOptionsToPackage{dvips}{graphicx}
\fi

\DeclareOption{projet}{
  \dm@s@isDrafttrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gestion des options graphiques %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% option draft : passe l'option draft \`a graphicx 
%%  - les graphiques sont remplac\'es par des rectangles
%%      avec le nom du fichier
\DeclareOption{draft}{%
  \setlength{\overfullrule}{5mm}
  \ifdm@sPDF
    \PassOptionsToPackage{draft}{graphicx}
  \else
    \PassOptionsToPackage{draft}{graphicx}
  \fi}

%% option final : passe l'option final \`a graphicx 
\DeclareOption{final}{%
  \ifdm@sPDF
    \PassOptionsToPackage{final}{graphicx}
  \else
    \PassOptionsToPackage{final}{graphicx}
  \fi}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% encodages de caracteres %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{utf8}{
  \PassOptionsToPackage{utf8}{inputenc}}
\DeclareOption{ansinew}{
  \PassOptionsToPackage{ansinew}{inputenc}}
\DeclareOption{latin1}{
  \PassOptionsToPackage{latin1}{inputenc}}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options inactive     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \PackageWarning{12pt}{Option '\CurrentOption' inconnue}
%% \DeclareOption{12pt}{\OptionNotUsed}
%% \PackageWarning{docDTN}{'\CurrentOption' inactive. Les cadres sont faits pour du 11pt}}

\ProcessOptions\relax


\ifdm@s@isArticle
  \LoadClassWithOptions{article}
\fi
\ifdm@s@isReport
  \LoadClassWithOptions{report}
\fi
\ifdm@s@isBook
  \LoadClassWithOptions{book}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options par d\'efaut    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{11pt,a4paper,ansinew}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% D\'eclarations pr\'eliminaires %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{babel}
%\RequirePackage{inputenc}    %%- [latin1] dans le fichier NT.tex
\RequirePackage[T1]{fontenc}          %%
\RequirePackage{titlesec}
\RequirePackage{graphicx}
\RequirePackage{pifont}             %% caract\`ere sp\'ecial pour pr\'eciser le mode de diffusion
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage{calc}
\usepackage{tabularx}
\RequirePackage{array}
\RequirePackage{lastpage}           %% le nombre total de page
\RequirePackage{fancyhdr}
\RequirePackage{placeins}
\RequirePackage{mathptmx}                   %% |
\RequirePackage[scaled=.9]{helvet}          %% | these three packages replace pslatex
\RequirePackage{courier}                    %% |
\renewcommand*\familydefault{\sfdefault}
\RequirePackage{setspace}
\RequirePackage{ifthen}
\RequirePackage{colortbl}
\RequirePackage{multirow}
\RequirePackage{amsmath}
\RequirePackage{helvetCEA} %% caract\`ere sp\'ecial pour NT CEA + pour \textsc \textbf 
\definecolor{myblue}{RGB}{70,130,180}
\definecolor{myred}{RGB}{255,127,42} 
\definecolor{mygreen}{RGB}{0,170,68} 

%% Pour la gestion des liens hypertext dans pdf
\ifdm@sPDF
  \PassOptionsToPackage{hyphens}{url}
  \RequirePackage[pdftex,breaklinks=true,colorlinks=true,linkcolor=black,citecolor=myblue,urlcolor=myblue]{hyperref}
\fi

\AtEndOfClass{\InputIfFileExists{docDTN.cfg}{\typeout{classe docDTN : utilise fichier de configuration locale}}{}}

%%%%%%Extensions ajout�es%%%%%%


\usepackage{caption}%d�finir proprement les l�gendes%
\usepackage[labelformat=simple]{subcaption}%d�finir proprement les l�gendes des sous-figures
\usepackage{sistyle}
\usepackage[retainorgcmds]{IEEEtrantools}%outil pour �quations multi-�tag�es 
\usepackage[leqno,fleqn,intlimits]{empheq}
\usepackage{fancybox}

%%%%%%Nouvelles commandes%%%%%%

\renewcommand{\tabularxcolumn}[1]{>{\arraybackslash}m{#1}}
\newcolumntype{W}{>{\centering\arraybackslash}X}
\newcommand*{\barheader}{%
{\vcenter{\hbox{}\vskip-.85ex\hbox{\Large |}}}}
\newcommand*{\barfooter}{%
{\vcenter{\hbox{}\vskip-4.25ex\hbox{\Large |}}}}
\newcommand{\partialJ}{\partial\hskip-.25ex}
\newcommand*{\squarebullet}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.8ex\hbox{\Large .}\vskip-.35ex\hbox{}}}}
\newcommand*{\Diamondfilled}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\FilledDiamondshape}\vskip-.35ex\hbox{}}}}
\newcommand{\diffi}{\,\mathrm{d}}%D�finition du espace d droit de diff�rentielle "int�grale"
\newcommand{\diff}{\mathrm{d}}%D�finition du d droit de diff�rentielle "d�riv�e"
\newcommand{\diffD}{\mathrm{D}}%D�finition du D droit de d�riv�e lagrangienne
\newcommand{\indrm}[2]{ #1_{\mathrm{#2}} } %D�finition de l'indice "droit":\indrm{fonction � indicer}{indice}
\newcommand{\norm}[1]{ \left|\!\left| #1 \right|\!\right| }%d�finition de la norme
\newcommand{\normline}[1]{|\!| #1 |\!| }%d�finition de la norme
\newcommand{\indic}[1]{\color{red}TO LINK \color{black}}
\newcommand{\e}[1]{\,\mathrm{e}^{#1}}%d�finition de l'exponentielle "droite" expos�e
\newcommand{\erf}{\text{erf}}
\newcommand{\clearemptydoublepage}{%
	\newpage{\pagestyle{empty}\cleardoublepage}}%pour la classe livre, �viter les en-t�tes sur les pages laiss�es vierges en fin de chapitre, table des mati�res, etc...� placer � chaque fin de chapitre
\newcommand{\Registeredmark}{$^{\mbox{\scriptsize{\textregistered}}}\,$}%d�finit la marque d�pos�e (R) en exposant
\newcommand{\Trademark}{$^{\mbox{\scriptsize{\texttrademark}}}\,$}%d�finit la marque d�pos�e (TM) en exposant
\newcommand{\Copyright}{$^{\mbox{\scriptsize{\copyright}}}\,$}%d�finit le droit de copie (R) en exposant
\newcounter{notetab}
\newcommand{\zero}{\setcounter{notetab}{0}}
\newcommand{\ntm}{\footnotemark\addtocounter{notetab}{1}}
\newcommand{\initnt}{\addtocounter{footnote}{-\value{notetab}}}
\newcommand{\ntt}[1]{%
   \addtocounter{footnote}{1}
   \footnotetext{#1}}
\newcommand{\laplacian}{\mathrm\Delta}
\newcommand{\laplacianvector}{\vec{\mathrm\Delta}}
\newcommand{\curl}{\overrightarrow{\mathrm{curl}}}
\newcommand{\rot}{\overrightarrow{\mathrm{rot}}}
\newcommand{\grad}{\overrightarrow{\mathrm{\hskip0.05ex grad}}}
\newcommand{\gradmatrix}{\Overrightarrow{\mathrm{\hskip0.05ex grad}}}
\newcommand{\diver}{\mathrm{div}}
\newcommand{\divervector}{\overrightarrow{\mathrm{\hskip0.05ex div}}}
\newcommand{\s}[1]{\smash{$#1$}}
\newcommand{\coeur}{c\oe ur}
\newcommand*\wideovalbox[1]{\color{myblue}\ovalbox{\hspace{0.25em}#1\hspace{0.25em}}}
\newcommand{\Celsius}{\,^{\circ}\mathrm{C}}
\newcommand{\matrixproduct}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{$\bullet$}\vskip-.35ex\hbox{}}}}
\newcommand*{\newotimes}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{$\otimes$}\vskip-.35ex\hbox{}}}}
\newcommand*{\circledone}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\ding{172}}\vskip-.35ex\hbox{}}}}
\newcommand*{\circledtwo}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\ding{173}}\vskip-.35ex\hbox{}}}}
\newcommand*{\circledthree}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\ding{174}}\vskip-.35ex\hbox{}}}}
\newcommand*{\circledfour}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\ding{175}}\vskip-.35ex\hbox{}}}}
\newcommand*{\circledfive}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\ding{176}}\vskip-.35ex\hbox{}}}}
\newcommand*{\warning}{%
{\vcenter{\offinterlineskip
\hbox{}\vskip-.35ex\hbox{\scriptsize\Radiation}\vskip-.35ex\hbox{}}}}

%%%%%%Nouveaux environnements%%%%%%

\renewcommand{\labelitemi}{$\squarebullet$}
\makeatletter
\setlength{\leftmargini}{1.162cm}
\newenvironment{packed_itemize}{
\begin{itemize}
  \setlength{\itemsep}{1pt}
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
}{\end{itemize}}%d�finition d'un espace restreint lors du d�marrage d'une liste � puces

%%%%%%%%%%Tableaux%%%%%%%%%%

\renewcommand{\arraystretch}{1.5}\renewcommand{\tabcolsep}{0.2cm}
\newcolumntype{P}[1]{>{\centering\arraybackslash}m{#1\textwidth}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                               % 
% Begin of Document Compilation %
%                               % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\AtBeginDocument{
  %% ============================
  %% Changer le nom  et centrer : 
  %%    Tables des mati\`eres -> Sommaire
  %%    Tables des figures  -> Liste des figures
  %%    Liste des Tableaux  -> Liste des Tableaux
  %% ============================
 \ifenglish
  \renewcommand\contentsname{\hfill \sc \bf Table of Contents \hfill }
  \renewcommand\listfigurename{\hspace{.45\textwidth} \sc \bf Figures}
  \renewcommand\listtablename{\hspace{.45\textwidth} \sc \bf Tables}
 \else
  \renewcommand\contentsname{\hfill \sc \bf Sommaire \hfill }
  \renewcommand\listfigurename{\hspace{.40\textwidth} \sc \bf Liste des Figures}
  \renewcommand\listtablename{\hspace{.40\textwidth} \sc \bf Liste des Tableaux}
 \fi
  %% ============================
  %% Si pas de valeur 'Indice' alors on met l'indice A
  %% ============================
  \ifnum\dm@s@lastIndice = 0
    \setindiceA{\dm@s@dateCompilation}{\dm@s@defaultNatureIndiceA}
  \fi
  %% ============================
  %% Si pas de valeur 'date' alors on met la valeur par defaut
  %% ============================
  \ifdm@s@haveNotDated
    \setdate{\dm@s@dateIndice}
  \fi
  %% ============================
  %% parametres graphiques PS/PDF
  %% ============================
  \ifdm@sPDF
    \DeclareGraphicsExtensions{.png,.jpg,.pdf}
  \else
    \DeclareGraphicsExtensions{.eps,.ps}
  \fi
  %% ============================
  %% Entete
  %% ============================
  \dm@s@aqmisenpagecategorieB
  \dm@s@clearEmptyDoublePage
  %% ============================
  %% Cas d'une publication
  %% ============================
  \ifdm@s@isPublication
  \else
    %% ============================
    %% Table des matieres
    %% ============================
    \tableofcontents
    %% ============================
    %% Table des figures
    %% ============================
    \ifdm@s@haveListOfFigures
      \listoffigures
   \fi
    %% ============================
    %% Liste des tableaux
    %% ============================
    \ifdm@s@haveListOfTables
      \listoftables
   \fi
    \dm@s@clearEmptyDoublePage
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%  End of Document Compilation  %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  \AtEndDocument{
    %%%%%%%%%%%%%%%%%%%%%% 
    %% Score AQ
    %%%%%%%%%%%%%%%%%%%%%% 
    \PackageWarning{Classe docDTN}{Score AQ \the\dm@s@ScoreAQ/\the\dm@s@MaxScoreAQ}
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%            Options            %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Red\'efinition de la mise en page
%%
%%
  \setlength{\oddsidemargin}{15mm}   %%{-0.5in}
  \setlength{\evensidemargin}{12.5mm}  %%{-0.5in}
  \setlength{\marginparwidth}{0mm}
  \setlength{\marginparsep}{0mm}
  \setlength{\topmargin}{5mm}
  \setlength{\headheight}{62mm} 
  \setlength{\headsep}{5mm}
  \setlength{\textwidth}{180mm}
  \setlength{\textheight}{218mm}
  \setlength{\footskip}{0mm}
  \setlength{\voffset}{-1.46in}
  \setlength{\hoffset}{-1in}
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%   raccourcis personnels       %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancyplain}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\renewcommand{\subsectionmark}[1]{\markright{#1}}
                                % champs \`a d\'efinir :
                                % ----------------------
\def\dm@s@dateCompilation{\number\day/\number\month/\number\year}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Interface utilisateur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% commandes obligatoires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titre
%%%%%%%%%%%%%%%%%%%%
\def\settitre#1{%
  \global\advance\dm@s@ScoreAQ\@ne
  \gdef\dm@s@titre{#1}}
%%%%%%%%%%%%%%%%%%%%%%
%% Auteurs
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@numberAuteur
\dm@s@numberAuteur = \z@
\newdimen\dm@s@hauteurResume
\dm@s@hauteurResume = 8cm

\newif\ifdm@s@auteurASignature
\dm@s@auteurASignaturetrue
\newif\ifdm@s@auteurBSignature
\dm@s@auteurBSignaturetrue
\newif\ifdm@s@auteurCSignature
\dm@s@auteurCSignaturetrue
\newif\ifdm@s@auteurDSignature
\dm@s@auteurDSignaturetrue
\newif\ifdm@s@auteurESignature
\dm@s@auteurESignaturetrue
\newif\ifdm@s@auteurFSignature
\dm@s@auteurFSignaturetrue
\newif\ifdm@s@auteurGSignature
\dm@s@auteurGSignaturetrue
\newif\ifdm@s@auteurHSignature
\dm@s@auteurHSignaturetrue

\def\dm@s@setAuteur#1#2#3{%
  \ifcase\dm@s@numberAuteur\or
  \def\dm@s@auteurAName{#1} \def\dm@s@auteurAFunction{#2} \def\dm@s@auteurAUnite{#3} \dm@s@auteurASignaturetrue \or
  \def\dm@s@auteurBName{#1} \def\dm@s@auteurBFunction{#2} \def\dm@s@auteurBUnite{#3} \dm@s@auteurBSignaturetrue \or
  \def\dm@s@auteurCName{#1} \def\dm@s@auteurCFunction{#2} \def\dm@s@auteurCUnite{#3} \dm@s@auteurCSignaturetrue \or
  \def\dm@s@auteurDName{#1} \def\dm@s@auteurDFunction{#2} \def\dm@s@auteurDUnite{#3} \dm@s@auteurDSignaturetrue \or
  \def\dm@s@auteurEName{#1} \def\dm@s@auteurEFunction{#2} \def\dm@s@auteurEUnite{#3} \dm@s@auteurESignaturetrue \or
  \def\dm@s@auteurFName{#1} \def\dm@s@auteurFFunction{#2} \def\dm@s@auteurFUnite{#3} \dm@s@auteurFSignaturetrue \or
  \def\dm@s@auteurGName{#1} \def\dm@s@auteurGFunction{#2} \def\dm@s@auteurGUnite{#3} \dm@s@auteurGSignaturetrue \or
  \def\dm@s@auteurHName{#1} \def\dm@s@auteurHFunction{#2} \def\dm@s@auteurHUnite{#3} \dm@s@auteurHSignaturetrue \fi
}

\def\dm@s@ajoutAuteur#1#2#3{%
  \ifnum\dm@s@numberAuteur < 8 %
    \global\advance\dm@s@numberAuteur\@ne
    \dm@s@setAuteur{#1}{#2}{#3}
  \else
    \PackageWarning{Classe docDTN}{8 auteurs maxi}%
  \fi
}

\def\setauteur#1#2{%
  \dm@s@ajoutAuteur{#1}{\dm@s@defaultFonctionAuteur}{#2}
}

\def\setauteurfonction#1#2#3{%
  \dm@s@ajoutAuteur{#1}{#2}{#3}
}

\def\addauteur#1#2{%
  \dm@s@ajoutAuteur{#1}{\dm@s@defaultFonctionAuteur}{#2}
}
\def\addauteurfonction#1#2#3{%
  \dm@s@ajoutAuteur{#1}{#2}{#3}
}

\def\dm@s@setAuteurSansSignature#1#2{%
  \ifcase\dm@s@numberAuteur\or
  \def\dm@s@auteurAName{#1} \def\dm@s@auteurAUnite{#2} \dm@s@auteurASignaturefalse \or
  \def\dm@s@auteurBName{#1} \def\dm@s@auteurBUnite{#2} \dm@s@auteurBSignaturefalse \or
  \def\dm@s@auteurCName{#1} \def\dm@s@auteurCUnite{#2} \dm@s@auteurCSignaturefalse \or
  \def\dm@s@auteurDName{#1} \def\dm@s@auteurDUnite{#2} \dm@s@auteurDSignaturefalse \or
  \def\dm@s@auteurEName{#1} \def\dm@s@auteurEUnite{#2} \dm@s@auteurESignaturefalse \or
  \def\dm@s@auteurFName{#1} \def\dm@s@auteurFUnite{#2} \dm@s@auteurFSignaturefalse \or
  \def\dm@s@auteurGName{#1} \def\dm@s@auteurGUnite{#2} \dm@s@auteurGSignaturefalse \or
  \def\dm@s@auteurHName{#1} \def\dm@s@auteurHUnite{#2} \dm@s@auteurHSignaturefalse \fi
}

\def\dm@s@ajoutAuteurSansSignature#1#2{%
  \ifnum\dm@s@numberAuteur < 8 %
    \global\advance\dm@s@numberAuteur\@ne
    \dm@s@setAuteurSansSignature{#1}{#2}
  \else
    \PackageWarning{Classe docDTN}{8 auteurs maxi}%
  \fi
}
\def\setauteursanssignature#1#2{
  \dm@s@ajoutAuteurSansSignature{#1}{#2}
}
\def\addauteursanssignature#1#2{
  \dm@s@ajoutAuteurSansSignature{#1}{#2}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commandes facultatives             %%
%%   au sens de la compilation LaTeX  %%
%%   mais obligatoire pour l'AQ       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%   Numero chrono
%%%%%%%%%%%%%%%%%%%%%%   
\def\setnumero#1{
  \global\advance\dm@s@ScoreAQ\@ne
  \dm@s@haveNumeroChronotrue
  \def\dm@s@numeroChrono{#1}}
%\def\dm@s@numeroChrono{\ifdm@s@DiffusionNormale DO \fi \ifdm@s@DiffusionRestreinte DR \fi #1}}

%%%%%%%%%%%%%%%%%%%%%% 
%% Numero de publication (PU)
%%%%%%%%%%%%%%%%%%%%%% 
\def\setnumeropublication#1{
  \ifdm@s@isPublication
    \dm@s@havenumeropublicationtrue
    \def\dm@s@numeropublication{#1}
  \else
    \ClassWarning{docDTN}{** le numero de publication est valable que pour une PUBLICATION **.}
  \fi}

%%%%%%%%%%%%%%%%%%%%%%
%% Gestion des indices
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@lastIndice
\dm@s@lastIndice  = \z@

\def\dm@s@indice{--}
\def\dm@s@dateIndice{--/--/--}

\def\dm@s@setIndice#1#2{
  \def\dm@s@indice{#1}
  \def\dm@s@dateIndice{#2}}



\def\d@teind@ce@{--/--/--}
\def\d@teind@ce@@{--/--/--}
\def\d@teind@ce@@@{--/--/--}
\def\l@gind@ce@{ ---   non d\'efini ----}
\def\l@gind@ce@@{ ---   non d\'efini ----}
\def\l@gind@ce@@@{ ---   non d\'efini ----}


%% Indice A
\def\setindiceA#1#2{%
  \ifnum\dm@s@lastIndice<1
    \dm@s@lastIndice = 1
    \dm@s@setIndice{A}{#1}
  \else
    \PackageError{Classe docDTN}{Indice A deja defini avec pour date("\d@teind@ce@") et nature ("\l@gind@ce@") }%
  \fi
  \def\d@teind@ce@{#1}
  \def\l@gind@ce@{#2}}

\def\setindiceAdate#1{%
  \setindiceA{#1}{\dm@s@defaultNatureIndiceA}}

\def\setindiceAnature#1{%
  \setindiceA{\dm@s@dateCompilation}{#1}}

\def\setindiceAlog#1{%
  \PackageWarning{Classe docDTN}{Deprecated method "setindiceAlog" : use "setindiceAnature" method}
  \setindiceAnature{#1}}


%% Indice B
\def\setindiceB#1#2{%
  \ifnum\dm@s@lastIndice<2
    \dm@s@lastIndice = 2
    \dm@s@setIndice{B}{#1}
  \else
    \PackageError{Classe docDTN}{Indice B deja defini avec pour date("\d@teind@ce@@") et nature ("\l@gind@ce@@") }%
  \fi
  \def\d@teind@ce@@{#1}
  \def\l@gind@ce@@{#2}}

\def\setindiceBall#1#2#3{%
  \setindiceB{#1}{#2}%
  \def\dm@s@PagesModifieesB{#3}}

\def\setindiceBnature#1{%
  \setindiceB{\dm@s@dateCompilation}{#1}}

\def\setindiceBlog#1{%
  \PackageWarning{Classe docDTN}{Deprecated method "setindiceBlog" : use "setindiceBnature" method}
  \setindiceBnature{#1}}

%% Indice C
\def\setindiceC#1#2{%
  \ifnum\dm@s@lastIndice<3
    \dm@s@lastIndice = 3
    \dm@s@setIndice{C}{#1}
  \else
    \PackageError{Classe docDTN}{Indice C deja defini avec pour date("\d@teind@ce@@@") et nature ("\l@gind@ce@@@") }%
  \fi
  \def\d@teind@ce@@@{#1}
  \def\l@gind@ce@@@{#2}}

\def\setindiceCall#1#2#3{%
  \setindiceC{#1}{#2}%
  \def\dm@s@PagesModifieesC{#3}}

\def\setindiceCnature#1{%
  \setindiceC{\dm@s@dateCompilation}{#1}}

\def\setindiceClog#1{%
  \PackageWarning{Classe docDTN}{Deprecated method "setindiceClog" : use "setindiceCnature" method}
  \setindiceCnature{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% References
%%   Reference A: interne DTN
%%   Reference B: pour une autre r\'ef\'erence externe au DER (ANDRA, Neptune, ...)
%%%%%%%%%%%%%%%%%%%%%% 
\def\dm@s@referenceANumber{\dm@s@abrService/\dm@s@abrLaboratoire/\dm@s@abrTypeDocument/\ifdm@s@haveNumeroChrono\dm@s@numeroChrono\else\textcolor{red}{\dm@s@defaultNumeroChrono}\fi
}

\def\setreferenceB#1#2{%
  \dm@s@haveReferenceExternetrue
  \def\dm@s@referenceBName{#1}%
  \def\dm@s@referenceBNumber{#2}%
}

%%%%%%%%%%%%%%%%%%%%%%
%% Resume
%%%%%%%%%%%%%%%%%%%%%%
\def\setresume#1{%
  \def\dm@s@Resume{#1}
  \ifdm@s@isSpecification
    \dm@s@haveResumefalse
    \ClassWarning{docDTN}{** le resume est prohibe pour une SPECIFICATION **.}%
  \else
    \dm@s@haveResumetrue
  \fi
}

\def\setresumeDO#1{%
  \ifdm@s@DiffusionNormale
    \ClassWarning{docDTN}{** pas de resumeDO pour une diffusion normale **.}%
  \else
    \dm@s@haveResumeDOtrue
    \def\dm@s@resumeDO{#1}
  \fi}

\def\setresumeanglais#1{%
  \dm@s@haveResumeAnglaistrue
  \def\dm@s@resumeAnglais{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionInterne
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@havediffusioninterne
\dm@s@havediffusioninternefalse
\def\setdiffusioninterne#1{%
  \dm@s@havediffusioninternetrue
  \def\dm@s@DiffusionInterne{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionExterne
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@havediffusionexterne
\dm@s@havediffusionexternefalse
\def\setdiffusionexterne#1{%
  \dm@s@havediffusionexternetrue
  \def\dm@s@DiffusionExterne{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionResume
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@haveDiffusionResume
\dm@s@haveDiffusionResumefalse
\def\setdiffusionresume#1{%
  \dm@s@haveDiffusionResumetrue
  \def\dm@s@DiffusionResume{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Most cles
%%%%%%%%%%%%%%%%%%%%%%
\def\setmotscles#1{%
  \dm@s@haveMotsClefstrue
  \def\dm@s@MotsClefs{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Parteanires/clients
%% References Acoord/contrat
%% Type Action
%%%%%%%%%%%%%%%%%%%%%%
\def\setreferencesaction#1#2#3{%
  \dm@s@havereferenceactiontrue
  \def\dm@s@partenaires{#1}
  \def\dm@s@referenceAccord{#2}
  \def\dm@s@typeAction{#3}}

%%%%%%%%%%%%%%%%%%%%%%
%% DOB/Programme
%%%%%%%%%%%%%%%%%%%%%%
\def\setaffaire#1#2{%
  \dm@s@havedobtrue
  \gdef\dm@s@DOB{#1}
  \gdef\dm@s@ProgrammeName{#2}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Nom du projet
%%%%%%%%%%%%%%%%%%%%%%
\def\setprojet#1{%
  \dm@s@haveprojettrue
  \gdef\dm@s@ProjetName{#1}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Num\'ero EOTP
%%%%%%%%%%%%%%%%%%%%%%
\def\seteotp#1{%
  \dm@s@haveeotptrue
  \gdef\dm@s@EOTP{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% References internes CEA                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newif\ifdm@s@havereferenceinterne
\dm@s@havereferenceinternefalse
\def\setreferencesinterne#1#2#3#4{%
  \dm@s@havereferenceinternetrue
  \gdef\dm@s@DOB{#1}
  \gdef\dm@s@ProgrammeName{#2}
  \gdef\dm@s@ProjetName{#3}
  \gdef\dm@s@EOTP{#4}
}

%%%%%%%%%%%%%%%%%%%%%%
%% JALON
%%%%%%%%%%%%%%%%%%%%%%
\def\setjalon#1#2{%
  \dm@s@haveJalontrue
  \def\dm@s@jalonName{#1}
  \def\dm@s@jalonTitle{#2}
}

%%%%%%%%%%%%%%%%%%%%%% 
%% Delai de Confidentialit\'e
%%%%%%%%%%%%%%%%%%%%%% 
\def\setdelaiconfidentialite#1{%
  \dm@s@haveDelaiConfidentialitetrue
  \def\dm@s@delaiConfidentialite{#1}
}

%%%%%%%%%%%%%%%%%%%%%% 
%% Cahier de Laboratoire
%%%%%%%%%%%%%%%%%%%%%% 
\def\setcahierlaboratoire#1{%
  \dm@s@haveCahierLaboratoiretrue
  \def\dm@s@cahierLaboratoire{#1}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Date officielle
%%%%%%%%%%%%%%%%%%%%%%
\def\setdate#1{%
  \dm@s@haveNotDatedfalse
  \def\dm@s@dateOfficielle{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Niveau de diffusion
%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@putDingDiffusion#1{#1 \hspace{15mm} {\large{\ding{56}}} \hspace{15mm}\fi}

\def\setdiffusion#1{
  \ifthenelse{\equal{#1}{restreinte}}{\dm@s@DiffusionRestreintetrue%%
    \ifdm@s@isDraft
		\def\textetimbre{PROJET \& DR}
	\else
		\def\textetimbre{DIFFUSION RESTREINTE}
	\fi
	\ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
  \fi}{\dm@s@DiffusionRestreintefalse}
  \ifthenelse{\equal{#1}{CEA}}{\dm@s@DiffusionCCEAtrue%%
    \ifdm@s@isDraft
		\def\textetimbre{PROJET \& CCEA}
	\else
		\def\textetimbre{CONFIDENTIEL CEA}
	\fi
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
  \fi}{\dm@s@DiffusionCCEAfalse}
  \ifthenelse{\equal{#1}{CD}}{\dm@s@DiffusionCDtrue%%
    \ifdm@s@isDraft
		\def\textetimbre{PROJET \& CD}
	\else
		\def\textetimbre{CONFIDENTIEL DEFENSE}
	\fi
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
  \fi}{\dm@s@DiffusionCDfalse}
  \ifthenelse{\equal{#1}{SD}}{\dm@s@DiffusionSDtrue%%
  	\ifdm@s@isDraft
		\def\textetimbre{PROJET \& SD}
	\else
		\def\textetimbre{SECRET DEFENSE}
	\fi
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
  \fi}{\dm@s@DiffusionSDfalse}
  \def\timbre{\raisebox{1ex}{\fboxrule0pt \fboxsep3mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{\textetimbre}}}}}}
  \ifthenelse{\equal{#1}{normale}}{\dm@s@DiffusionNormaletrue%%
	\ifdm@s@isDraft
		\def\timbre{\Large{\textcolor{red}{\textbf{PROJET}}}}
	\else
%		\def\timbre{}
                \dm@s@haveTimbrefalse
	\fi
  }{\dm@s@DiffusionNormalefalse}
}
%%%%%%%%%%%%%%%%%%%%%%
%% Action off 
%%    List figures
%%    List tables
%%    Timbre
%%%%%%%%%%%%%%%%%%%%%%
\def\nolistoffigures{%
  \dm@s@haveListOfFiguresfalse}
\def\nolistoftables{%
  \dm@s@haveListOfTablesfalse}
\def\notimbre{%
  \dm@s@haveTimbrefalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Valeurs par d\'efaut
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% OBLIGATOIRE
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifdm@s@isSpecification
  \else
    \setresume{\textcolor{red}{\Large R\'esum\'e \`a r\'ediger via la commande \textbackslash setresume\{\}.}}
  \fi
  \ifdm@s@isPublication
    \setresumeanglais{\textcolor{red}{\Large R\'esum\'e ANGLAIS \`a r\'ediger via la commande \textbackslash setresumeanglais\{\}.}}
  \fi
  \setmotscles{\textcolor{red}{\Large Mots cles \`a d\'efinir via la commande \textbackslash setmotscles\{\}.}}
  \setverificateur{\textcolor{red}{\small \textbackslash setverificateur\{1\}\{2\} --Arg1--}}{\textcolor{red}{\footnotesize --Arg2--}}

%%  \setdiffusion{normale}
  \setreferencesinterne{\textcolor{red}{\footnotesize \textbackslash setreferencesinterne\{1\}\{2\}\{3\}\{4\}}}{\textcolor{red}{\footnotesize --Arg2--}}{\textcolor{red}{\footnotesize --Arg3--}}{\textcolor{red}{\footnotesize --Arg4--:X-XXXX-YY-ZZ-UU-VZ}}


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% FACAULTATIF
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %% 
 %%  
 %%  ____________________________________________________________________________ 
 %% |                                                                            | 
 %% |                  Red\'efinition de la mise en page                         | 
 %% |____________________________________________________________________________| 
 %%
 %%
 \def\dm@s@aqmisenpagecategorieB{

   
   %% 
   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                       Ent�te et pieds de pages                             |
   %% |____________________________________________________________________________|
   %%
   \chead{\dm@s@cadreHautPage}
   \rhead{}
   \lhead{}

   \cfoot{\dm@s@footerNote}
   \lfoot{}
   \rfoot{}
   \renewcommand{\headrulewidth}{0.0pt}

   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                                PAGE 1 : PAGE DE GARDE                      |
   %% |____________________________________________________________________________|
   %%
   \newpage
   
   \setlength{\parindent}{0mm}
   \ \\
   \vspace{2cm}
   \begin{center}
     \raisebox{30mm}[0pt]{\large \dm@s@direction}\\
     \raisebox{30mm}[0pt]{\large \dm@s@sousdirection}\\
     \raisebox{30mm}[0pt]{\large \dm@s@departement}\\
     \raisebox{30mm}[0pt]{\large \dm@s@service}\\
     \raisebox{30mm}[0pt]{\large \dm@s@laboratoire}\\

     
     \begin{minipage}[c][12mm][c]{180mm}
       \begin{center}
         \LARGE \bf {\dm@s@titre}
       \end{center}
     \end{minipage}
     
     \vspace{\stretch{4}}
     
     {           {\Large \bf \dm@s@auteurAName   \\
                  \large \normalfont (\dm@s@auteurAUnite) \\
             \ifnum\dm@s@numberAuteur>1
                  \Large \bf \dm@s@auteurBName   \\
                  \large \normalfont (\dm@s@auteurBUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>2
                  \Large \bf \dm@s@auteurCName   \\
                  \large \normalfont (\dm@s@auteurCUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>3
                  \Large \bf \dm@s@auteurDName   \\
                  \large \normalfont (\dm@s@auteurDUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>4
                  \Large \bf \dm@s@auteurEName   \\
                  \large \normalfont (\dm@s@auteurEUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>5
                  \Large \bf \dm@s@auteurFName   \\
                  \large \normalfont (\dm@s@auteurFUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>6
                  \Large \bf \dm@s@auteurGName   \\
                  \large \normalfont (\dm@s@auteurGUnite) \\
             \fi
             \ifnum\dm@s@numberAuteur>7
                  \Large \bf \dm@s@auteurHName   \\
                  \large \normalfont (\dm@s@auteurHUnite) \\
             \fi
                 }
     }
     
     \vspace{\stretch{2}}
     
     %% Reference A : CEA/DEN/DER
     \ifdm@s@isderdir
       {\large \dm@s@ReferenceAName\ \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@referenceANumber} \\
     \else
       {\large \dm@s@ReferenceAName\ \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@referenceANumber\hspace{0.4mm} }
     \fi
      {\large Indice \dm@s@indice}\\
     %% Reference B si existe
     \ifdm@s@haveReferenceExterne
       \vspace{\stretch{2}}
       {\large \bf \dm@s@referenceBName : \dm@s@referenceBNumber}\\
     \fi
     \vspace{\stretch{1}}
     \ifdm@s@isDraft
       \Large{\textcolor{red}{PROJET}}\\
     \else
       \Large{\phantom{PROJET}}
     \fi
     \ifthenelse{\equal{\dm@s@referenceAccord}{}}{}{%
       \vspace{\stretch{2}}
       \ifenglish
       {\large \bf This document issued by CEA falls within the scope of agreement} \\
       \else
       {\large \bf Document \'emis dans le cadre de l'accord} \\
       \fi
       {\dm@s@referenceAccord}}
     \vspace{\stretch{10}}
   \end{center}
   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 2 : Fiche Documentaire                      |
   %% |____________________________________________________________________________|
   %%
   \setlength{\extrarowheight}{0mm}
   \newpage
   \renewcommand{\arraystretch}{1.5}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Confidentialit\'e                      %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   \vspace{5mm}
   
   \begin{tabularx}{503.5pt}{|W|W|W|W|W|}
         \hline
      \ifenglish
         \multicolumn{5}{|c|}{  {\small \sc \bf Level of Confidentiality}} \\
      \else
         \multicolumn{5}{|c|}{  {\small \sc \bf Niveau de Confidentialit\'e}} \\
      \fi
         \hline
         DO & DR & CCEA & CD & SD\\
         \hline
         \hspace{-15mm}\dm@s@putDingDiffusion{\ifdm@s@DiffusionNormale} & \hspace{-15mm}\dm@s@putDingDiffusion{\ifdm@s@DiffusionRestreinte} & \hspace{-15mm}\dm@s@putDingDiffusion{\ifdm@s@DiffusionCCEA}  & \hspace{-15mm}\dm@s@putDingDiffusion{\ifdm@s@DiffusionCD}  & \hspace{-15mm}\dm@s@putDingDiffusion{\ifdm@s@DiffusionSD} \\
         \hline
   \end{tabularx}
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Partenaire/Action                      %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   \vspace{5mm}
   
   \begin{tabularx}{503.5pt}{|>{\hsize=1.1\hsize}W|>{\hsize=1.2\hsize}W|>{\hsize=.7\hsize}W|}
     \hline 
     %--------------
     \ifenglish
     %--------------
           {\sc Partners/Customers}     & {\sc Agreement}         & {\sc \centering Type of Action} \\
           \hline
        \ifdm@s@havereferenceaction
           \dm@s@partenaires            &  \dm@s@referenceAccord  &  \dm@s@typeAction               \\
        \else
                                        &                         &                                 \\
        \fi
     %--------------
     \else
     %--------------
           {\sc Partenaires/Clients}    & {\sc Accord}            & {\sc \centering Type d'action}  \\
           \hline
        \ifdm@s@havereferenceaction
           \dm@s@partenaires            &  \dm@s@referenceAccord  &  \dm@s@typeAction               \\
        \else
                                        &                         &                                 \\
        \fi
     %--------------
     \fi
     %--------------
     \hline
   \end{tabularx}
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% References internes CEA                %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabularx}{503.5pt}{|W|W|W|W|}
      \hline
    \ifenglish
      \multicolumn{4}{|c|}{ {\small \sc \bf CEA Internal References}} \\
      \hline
      {\sc {\small Management by Objectives}} & {\sc Domain} & {\sc Project} & {\sc EOTP} \\
      \hline
    \else
      \multicolumn{4}{|c|}{ {\small \sc \bf R\'ef\'erences Internes CEA}} \\
      \hline
      {\sc {\small Direction d'objectifs}} & {\sc Domaine} & {\sc Projet} & {\sc EOTP} \\
      \hline
    \fi
     \dm@s@DOB & \dm@s@ProgrammeName & \dm@s@ProjetName & \dm@s@EOTP \\
     \hline
    \ifenglish
     {\sc \small Milestone} & {\sc \small Milestone Title} & {\sc \small Time Limit of Confidentiality} &  {\sc \small Laboratory Specifications} \\
    \else
     {\sc \small Jalon} & {\sc \small Intitule du jalon} & {\sc \small Delai contractuel de confidentialit\'e} &  {\sc \small Cahiers de laboratoire} \\
    \fi
     \hline
     \ifdm@s@haveJalon \dm@s@jalonName \fi & \ifdm@s@haveJalon \dm@s@jalonTitle \fi & \ifdm@s@haveDelaiConfidentialite \dm@s@delaiConfidentialite \fi & \ifdm@s@haveCahierLaboratoire \dm@s@cahierLaboratoire \fi \\
     \hline
   \end{tabularx}
  
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Suivi des versions                     %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabularx}{503.5pt}{|>{\hsize=.5\hsize}W|>{\hsize=0.75\hsize}W|>{\hsize=1.375\hsize}W|>{\hsize=1.375\hsize}W|}
      \hline
     \ifenglish
      \multicolumn{4}{|c|}{ {\sc Amendment Record Sheet}} \\
      \hline
      { {\sc Version}} & { {\sc Date}}  & { {\sc Description}} & { {\sc Pages/Chapiters/Appendices}} \\
     \else
      \multicolumn{4}{|c|}{ {\sc Suivi des versions}} \\
      \hline
      { {\sc Indice}} & { {\sc Date}}  & { {\sc Nature de l'\'evolution}} & { {\sc Pages/chapitres}} \\
     \fi
      \hline
      A                   & \d@teind@ce@ &  \l@gind@ce@   &  \\
      \ifnum\dm@s@lastIndice>1
      \hline
      B                   & \d@teind@ce@@ & \l@gind@ce@@  & \dm@s@PagesModifieesB \\
      \fi
      \ifnum\dm@s@lastIndice>2
      \hline
      C                   & \d@teind@ce@@@ & \l@gind@ce@@@ &  \dm@s@PagesModifieesC \\
      \fi
      \hline
      &&&\\
      \hline
   \end{tabularx}

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %% Signatures                             %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \renewcommand{\arraystretch}{1.75}
   \ifnum\dm@s@numberAuteur<5
   \setlength{\extrarowheight}{-0.5mm}
   \else
   \setlength{\extrarowheight}{0mm}
   \fi
   
   \begin{tabularx}{503.5pt}{|>{\hsize=.85\hsize}W|>{\hsize=1.65\hsize}W|>{\hsize=1.25\hsize}W|>{\hsize=.5\hsize}W|>{\hsize=.75\hsize}W|}
      \hline
      \ifenglish
                                   &  \textsc{Name}          & {\sc Position}               & {\sc Date} & {\sc Signature} \\
      \hline
      {\sc {\bf Written by}}       & \dm@s@auteurAName       &  \dm@s@auteurAFunction       &            &                 \\
      \else
                                   &  \textsc{Nom}           & {\sc Fonction}               & {\sc Date} & {\sc Visa}      \\
      \hline
      {\sc{\bf R�dacteur}}         & \dm@s@auteurAName       &  \dm@s@auteurAFunction       &            &                 \\
      \fi
      \hline
      \ifnum\dm@s@numberAuteur>1
      \ifdm@s@auteurBSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurBName       &  \dm@s@auteurBFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurBName       &  \dm@s@auteurBFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>2
      \ifdm@s@auteurCSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurCName       &  \dm@s@auteurCFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurCName       &  \dm@s@auteurCFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>3
      \ifdm@s@auteurDSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurDName       &  \dm@s@auteurDFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurDName       &  \dm@s@auteurDFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>4
      \ifdm@s@auteurESignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurEName       &  \dm@s@auteurEFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurEName       &  \dm@s@auteurEFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>5
      \ifdm@s@auteurFSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurFName       &  \dm@s@auteurFFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurFName       &  \dm@s@auteurFFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>6
      \ifdm@s@auteurGSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurGName       &  \dm@s@auteurGFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurGName       &  \dm@s@auteurGFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifnum\dm@s@numberAuteur>7
      \ifdm@s@auteurHSignature
      \ifenglish
      {\sc {\bf Written by}}       & \dm@s@auteurHName       &  \dm@s@auteurHFunction       &            &                 \\
      \else
      {\sc{\bf R�dacteur}}         & \dm@s@auteurHName       &  \dm@s@auteurHFunction       &            &                 \\
      \fi
      \hline
      \fi
      \fi
      \ifenglish
      {\sc {\bf Checked by}}       & \dm@s@verificateurAName &  \dm@s@verificateurAFunction &            &                 \\
      \else
      {\sc{\bf V�rificateur}}      & \dm@s@verificateurAName &  \dm@s@verificateurAFunction &            &                 \\
      \fi
      \hline 
      \ifnum\dm@s@numberVerificateur>2
      \ifenglish
      {\sc {\bf Checked by}}       & \dm@s@verificateurBName &  \dm@s@verificateurBFunction &            &                 \\
      \else
      {\sc{\bf V�rificateur}}      & \dm@s@verificateurBName &  \dm@s@verificateurBFunction &            &                 \\
      \fi
      \hline 
      \fi
      \ifenglish
      {\sc {\bf Approved by}}      & \dm@s@approbateurName   &  \dm@s@approbateurFunction   &            &                 \\
      \else
      {\sc{\bf Approbateur}}       & \dm@s@approbateurName   &  \dm@s@approbateurFunction   &            &                 \\
      \fi
      \hline 
      \ifenglish
      {\sc {\bf Issued by}}        & \dm@s@emetteurName      &  \dm@s@emetteurFunction      &            &                 \\
      \else
      {\sc{\bf \'Emetteur}}          & \dm@s@emetteurName      &  \dm@s@emetteurFunction      &            &                 \\
      \fi
      \hline
   \end{tabularx}
   
   
   \setlength{\extrarowheight}{0mm}

   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 3 : RESUME                                  |
   %% |____________________________________________________________________________|
   %%
   \newpage
   %%
   %% Divise la hauteur du r\'esum\'e dans le cas d'une publication
   %%
   %%% \ClassWarning{docDTN}{*** la hauteur du resume \the\dm@s@hauteurResume ***.}%
   \ifdm@s@isPublication
     \divide\dm@s@hauteurResume2\relax
   \fi
   %%% \ClassWarning{docDTN}{*** la hauteur du resume \the\dm@s@hauteurResume ***.}%
   %%

   \vspace{\stretch{1}}
   
   \ifenglish
   \textbf{\large \textsc{Key words}}
   \else
   \textbf{\large \textsc{Mots clefs}}
   \fi

   \vspace{5pt}
   \fbox{\parbox[t]{174.5mm}{\dm@s@MotsClefs}}

   \vspace{\stretch{0.2}}

   \ifdm@s@haveResume
   \ifenglish
   \parbox[c]{174.5mm}{\textbf{\textsc{Abstract/Conclusion}} {\small subject to the same level of confidentiality as the rest of the document}}
   \else
   \parbox[c]{174.5mm}{\textbf{\textsc{Resume/Conclusions}} {\small de m\^eme niveau de confidentialit\'e que le document}}
   \fi
   
   \vspace{5pt}
%    \fbox{\parbox[t][\dm@s@hauteurResume][t]{174.5mm}{\dm@s@Resume}}
   \fbox{\parbox[t]{174.5mm}{\dm@s@Resume}}
   \fi

   \vspace{\stretch{0.2}}
   
   \ifenglish
   \parbox[c]{174.5mm}{\textbf{\textsc{Abstract/Conclusion}} {\small if the DEN technical document is of a higher level of confidentiality}}
   \else
   \parbox[c]{174.5mm}{\textbf{\textsc{Resume/Conclusions}} {\small r\'edig\'e pour \^etre de niveau DO, si le document est de niveau DR, CCEA, CD ou SD}}
   \fi
   
   \vspace{5pt}
   \ifenglish
%    \fbox{\parbox[t][\dm@s@hauteurResume][t]{174.5mm}{\ifdm@s@haveResumeDO{\dm@s@resumeDO}\else{Not applicable}\fi}}
   \fbox{\parbox[t]{174.5mm}{\ifdm@s@haveResumeDO{\dm@s@resumeDO}\else{Not applicable}\fi}}
   \else
   \fbox{\parbox[t][\dm@s@hauteurResume][t]{174.5mm}{\ifdm@s@haveResumeDO{\dm@s@resumeDO}\else{Sans objet}\fi}}
   \fi
   
   \vfill
   
   \setlength{\parindent}{5mm}
   
   %% ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 4 : DIFFUSION INITIALE                      |
   %% |____________________________________________________________________________|
   %%
   \newpage
   \setlength{\parindent}{0pt}
   \vspace{\stretch{1}}

  \ifdm@s@DiffusionNormale
    \ifenglish
    {\hfill \large \bf \textsc{ Distribution (by E-Mail)} \hfill} \\
    \else
    {\hfill \large \bf \textsc{ Diffusion Initiale (par Courriel)} \hfill} \\
    \fi
   \else
    \ifenglish
    {\hfill \large \bf \textsc{ Distribution (by encrypted E-Mail)} \hfill} \\
    \else
    {\hfill \large \bf \textsc{Diffusion Electronique Crypt�e (ou cd)} \hfill} \\
    \fi
   \fi
   
  \ifdm@s@havediffusioninterne
   \dm@s@DiffusionInterne
  \fi

  \vspace{\stretch{5}}
   
  }
  
 \setlength{\parindent}{5mm}
 %%  ____________________________________________________________________________
 %% |                                                                            |
 %% |             CADRE en haut des pages                                        |
 %% |____________________________________________________________________________|
 %% 
 \def\dm@s@cadreHautPage{%%
   \renewcommand{\arraystretch}{1.5}
   \ifthenelse{\value{page}=1}{
%
% Page 1
%
     \begin{tabular}{|@{}p{55.5mm}@{}|@{}>{\centering}m{62mm}@{}|@{}p{31.75mm}@{}|@{}p{18.25mm}@{}|}
       \hline
       \multicolumn{1}{|c|}{\multirow{3}{50mm}[22pt]{\includegraphics[width=50.5mm,height=39mm]{CEA_FR_logotype}}}  
       &\begin{minipage}[c][27mm][c]{62mm}
           \ifdm@s@haveTimbre
              \centering \timbre\\
              \ifdm@s@DiffusionRestreinte
                 \ifenglish
                    \vspace{8mm}\textcolor{red}{\textbf{\scriptsize Do not distribute without prior permission from the issuer}}
                 \else
                    \vspace{8mm}\textcolor{red}{\textbf{\scriptsize Ne pas diffuser sans autorisation de l'\'emetteur}}
                 \fi
              \fi
           \fi 
        \end{minipage}
       & \multicolumn{1}{c|}{\begin{minipage}[c][28.0mm][c]{55mm}
             { \hspace{2ex} \includegraphics[width=45mm]{GCAO.jpg}} 
                             \end{minipage}} \\
       \cline{2-3}
       & \begin{minipage}[c][15.0mm][c]{73mm} \hspace{\stretch{0.3}} \bf \MakeUppercase \dm@s@typeDocument\ \dm@s@abrDirection \hspace{\stretch{1}} \end{minipage} & 
         \multicolumn{2}{c|}{\begin{minipage}[c][11.5mm][c]{55mm} \hspace{\stretch{1}} Page~\thepage/\pageref{LastPage} \hspace{\stretch{1}} \end{minipage}} \\
       \hline
     \end{tabular}}
%
% Page <> 1
%
     {\renewcommand{\arraystretch}{1.3}
      \begin{tabular}{|@{}p{55.5mm}@{}|@{}>{\centering}m{42mm}@{}|@{}>{\centering}p{50mm}@{}|@{}>{\centering\arraybackslash}p{28.75mm}@{}|}
       \hline
       \multicolumn{1}{|l|}{\multirow{3}{45mm}[-5.75pt]{\includegraphics[width=51.5mm,height=38mm]{CEA_FR_logotype}}} 
       & & {\small \dm@s@typeDocument\ \dm@s@abrDirection}  & {\footnotesize Page~\thepage/\pageref{LastPage}}\\
       \cline{3-4}
       &\begin{minipage}[c][0mm][c]{60mm}
           \ifdm@s@haveTimbre
              \centering \timbre\\
              \ifdm@s@DiffusionRestreinte
                 \ifenglish
                    \vspace{8mm}\large{\textcolor{red}{\textbf{\scriptsize Do not distribute without prior permission from the issuer}}}
                 \else
                    \vspace{8mm}\large{\textcolor{red}{\textbf{\scriptsize Ne pas diffuser sans autorisation de l'\'emetteur}}}
                 \fi
              \fi
           \fi 
        \end{minipage}
       & \multicolumn{2}{c|}{
          \begin{minipage}[c][16.5mm][c]{74mm}
             \ifenglish
                {\fontsize{8.0pt}{1pt}\selectfont \underline{Agreement} : \ifthenelse{\equal{\dm@s@referenceAccord}{}}{\small SO}{\fontsize{8pt}{1pt}\selectfont \dm@s@referenceAccord}} \\
                {\fontsize{9.0pt}{1pt}\selectfont \underline{Ref.} : \fontsize{9pt}{1pt}\selectfont\dm@s@abrDirection/\-\dm@s@abrSousDirection/\-\dm@s@abrDepartement/\-\dm@s@referenceANumber} 
             \else
                {\fontsize{8.0pt}{1pt}\selectfont \underline{Accords} : \ifthenelse{\equal{\dm@s@referenceAccord}{}}{\small SO}{\fontsize{8pt}{1pt}\selectfont \dm@s@referenceAccord}} \\
                {\fontsize{9.0pt}{1pt}\selectfont \underline{R\'ef.} : \fontsize{9pt}{1pt}\selectfont\dm@s@abrDirection/\-\dm@s@abrSousDirection/\-\dm@s@abrDepartement/\-\dm@s@referenceANumber} 
             \fi
          \end{minipage}
          }\\
       \cline{3-4}
       \ifenglish
          &  & {\small Date : \dm@s@dateOfficielle }  & {\small \underline{Version}~:~\textbf{\dm@s@indice}}\\
       \else
          &  & {\small Date : \dm@s@dateOfficielle }  & {\small \underline{Indice}~:~\textbf{\dm@s@indice}}\\
       \fi
       \cline{2-4}
	   & \multicolumn{3}{l|}{%%
         \begin{minipage}[c][12.0mm][c]{110mm}
           \normalsize  \dm@s@titre
         \end{minipage} }\\
       \hline
     \end{tabular}}}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% macro : dm@s@clearEmptyDoublePage      %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% 
 \def\dm@s@clearEmptyDoublePage{
   \newpage{\pagestyle{empty}\cleardoublepage}}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% macro : dm@s@footerNote                %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifenglish

 \def\dm@s@footerNote{%%
 \ifthenelse{\value{page}=1}{%%
 \renewcommand{\arraystretch}{0.9}
 \vspace{-2.8cm}
 {\scriptsize
 \begin{tabular}{@{}p{160mm}m{16mm}m{16mm}}
       CEA (French Alternative Energies and Atomic Energy Commission) & & \\
       \dm@s@laboratoireCentre\ Center -- \dm@s@departement\ -- \dm@s@service & & \\
       Tel.:+33 4 42 25 \dm@s@laboratoireTel\  -- Fax : +33 4 42 25 \dm@s@laboratoireFax\ -- \href{mailto:\dm@s@laboratoireMail}{\dm@s@laboratoireMail}\ & & \\
       Public establishments of an industrial and commercial nature & & \\
       RCS PARIS B 775 685 019 & &  \\
       & & \\
 \end{tabular}}}{}
 
 \vspace{0.5cm}
 \hrulefill
 
 \vspace{0.1cm}
 \begin{spacing}{0.6}
 \textcolor{red}{\centering{\scriptsize
       This document is an exclusive property of CEA - all reproduction, even partial in any form whatsoever is strictly forbidden without written authorization \\
       This document issued by CEA falls within the scope of agreement \dm@s@referenceAccord\ - All reproduction and distribution rights are subject to the terms of the agreement \renewcommand{\baselinestretch}{1.0}  } }
 \end{spacing}
 }
 
\else
 
 \def\dm@s@footerNote{%%
 \ifthenelse{\value{page}=1}{%%
 \renewcommand{\arraystretch}{0.9}
 \vspace{-2.8cm}
 {\footnotesize
 \begin{tabular}{@{}p{160mm}m{16mm}m{16mm}}
       Commissariat \`a l'Energie Atomique et aux Energies Alternatives -- Centre de \dm@s@laboratoireCentre & & \\
       \dm@s@departement -- \dm@s@service & &\\
       \dm@s@laboratoire -- B\^atiment~\dm@s@laboratoireBatiment & &\\
       T\'el. : 04 42 25 \dm@s@laboratoireTel\  \hspace{2mm} Fax : 04 42 25 \dm@s@laboratoireFax\ -- \dm@s@laboratoireMail\ & & \\
       \'Etablissement public \`a caract\`ere industriel et commercial & & \\
       RCS PARIS B 775 685 019 & &  \\
       & & \\
 \end{tabular}} }{}
 
 \vspace{0.5cm}
 \hrulefill
 
 \vspace{0.1cm}
 \begin{spacing}{0.6}
 \textcolor{red}{\centering{\scriptsize 
       Document propri\'et\'e du CEA - Reproduction et diffusion externes au CEA soumises \`a l'autorisation de l'\'emetteur \\
       Document \'emis par le CEA dans le cadre des accords \dm@s@referenceAccord\ - Reproduction et diffusion soumises aux termes des accords} }
 \end{spacing}
 }
 
\fi
 
 %% ----------------------
 \sloppy

 \setcounter{secnumdepth}{5}
 \setcounter{tocdepth}{5}

%Table des Matieres
%\makeatletter
%\renewcommand\l@section[2]{%
%\ifnum \c@tocdepth >\z@
%\addpenalty\@secpenalty
%\addvspace{1.0em \@plus\p@}% espace entre section
%\setlength\@tempdima{1.5em}%
%\begingroup
%\parindent \z@ \rightskip \@pnumwidth
%\parfillskip -\@pnumwidth
%\leavevmode {\bfseries
%\advance\leftskip\@tempdima
%\hskip -\leftskip
%#1}\nobreak\ 
%\leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
%\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%\endgroup
%\fi}

%Indentation sections
\renewcommand\section{\leftskip 0ex \@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus .2ex}%
	{\normalfont\large\bfseries}}

\newcommand{\xsubsection}{\leftskip 0ex \@startsection{subsection}{2}{\z@}%
             {-3.25ex \@plus -1ex \@minus -.2ex}%
             {1.5ex \@plus .2ex}%
             {\normalfont\large\bfseries}}
\renewcommand\subsection[1]{\xsubsection{#1}}

\newcommand{\xsubsubsection}{\leftskip 0ex \@startsection{subsubsection}{3}{\z@}%
	     {-3.25ex \@plus -1ex \@minus -.2ex}%
             {1.5ex \@plus .2ex}%
             {\normalfont\large\bfseries}}
\renewcommand\subsubsection[1]{\xsubsubsection{#1}}

\newcommand{\xparagraph}{\leftskip 0ex \@startsection{paragraph}{4}{\z@}%
             {-3.25ex \@plus -1ex \@minus -.2ex}%
             {1.5ex \@plus .2ex}%
             {\normalfont\large\bfseries}}
\renewcommand\paragraph[1]{\xparagraph{#1}\leftskip 5.5ex}

\newcommand{\xsubparagraph}{\leftskip 0ex \@startsection{subparagraph}{5}%
	     {\z@}%
             {-3.25ex \@plus -1ex \@minus -.2ex}%
             {1.5ex \@plus .2ex}%
             {\normalfont\large\bfseries}}
\renewcommand\subparagraph[1]{\xsubparagraph{#1}\leftskip 7ex}

\makeatother

 %%%%%% fin de docDTN.cls
