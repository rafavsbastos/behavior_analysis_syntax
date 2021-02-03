#papaja is short for ‘preparing APA journal articles’ and is the name of this R 
#package designed to create fully reproducible journal articles that seamlessly
#fuse statistical analyses, simulations, and prose. A manuscript written with papaja 
#can be thought of as an extensively commented analysis script ready for publication 
#in a scientific journal.


#If you want to create PDF- in addition to DOCX-documents you additionally need
# TeX 2013 or later. If you have no use for TeX beyond rendering R Markdown 
#documents, I recommend you use TinyTex. Otherwise consider MikTeX for Windows, 
#MacTeX for Mac, or TeX Live for Linux. TinyTex can be installed from within R 
#as follows.

if(!"tinytex" %in% rownames(installed.packages())) install.packages("tinytex")

tinytex::install_tinytex()

#papaja requires additional LaTex packages that are not part of the basic TeX 
#installations. When using TinyTex, the required packages will be installed 
#automatically when rendering a the first PDF-document. Users of other TeX 
#distribution need to take one of the following additional steps. MikTeX users 
#may enable the automatic installation of missing packages. If you are 
#comfortable using the command line, it may be convenient to run the following command.

initexmf --set-config-value [MPM]AutoInstall=1

#papaja is not yet available on CRAN but you can install it from GitHub:

# Install devtools package if necessary
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
library(devtools)
# Install the stable development versions from GitHub
devtools::install_github("crsh/papaja")

# Install the latest development snapshot from GitHub
devtools::install_github("crsh/papaja@devel")

#citr is an R package that provides functions to search Bib(La)TeX-files to
#create and insert formatted Markdown citations into the current document. If 
#you use RStudio, the package supplies an easy-to-use RStudio add-in that 
#facilitates inserting citations (Figure 3.1 of 
#http://frederikaust.com/papaja_man/writing.html#fig:citr-gif). 
#The references for the inserted 
#citations are automatically added to the documents reference section.
install.packages("citr")

#or, if it's not in CRAN, use:
devtools::install_github("crsh/citr")

#If you use Zotero or Juris-M citr can access your reference database without 
#previous export. For this to work, you need to install the Better BibTeX 
#extension, which we recommend even if you don't intend to use citr. 
#Once the extension is installed and the reference manager is running, 
#citr will automatically access all your references and keep the Bib(La)Tex-file
#specified in the current R Markdown file up-to-date. If you dislike this 
#behavior, you can disable the automatic access to the reference manager by 
#setting options(citr.use_betterbiblatex = FALSE).
#Install Better BibTex for Zotero here
#https://retorque.re/zotero-better-bibtex/installation/



#For further use, see http://frederikaust.com/papaja_man/introduction.html
