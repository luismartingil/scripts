#!/bin/bash
#
# Bash script to install LaTeX and the .sty that I use most.
# Author: luismartingil
# Year: 2012
#
# Debian installation script

WEB=https://raw.github.com/luismartingil/scripts/master/latex/
ARRAY=(
    lstcustom.sty
    minted.sty
    )

TEMPLATE=template/
ARRAY_TEMPLATE=(
    Makefile
    main.tex
    section1.tex
    section2.tex
)
LOGO=logos/
ARRAY_LOGO=(
    company-logo-watermark.png
    company-logo.png
)



# Bash functions to install dependencies.
# Probably more deps than needed!
install_debian_req () {
    sudo apt-get install -y texlive-base texlive-fonts-recommended texlive-latex-base texlive-latex-recommended texify tetex-frogg  tex-gyre  texlive-xetex texlive-pictures texlive-luatex texlive-bibtex-extra  texlive-extra-utils  texlive-font-utils texlive-fonts-extra  texlive-formats-extra texlive-generic-extra texlive-games  texlive-plain-extra texlive-latex-extra texlive-science  tshark texlive-base texlive-fonts-recommended texlive-latex-base ttf-dejavu-core ttf-gfs-* ttf-dejavu ttf-liberation python-setuptools
    # Pygments is used for coloring and adding source files
    # in our LaTeX documents.
    sudo easy_install Pygments
}

# Please install the dependencies
install_debian_req

# Lets grab the .sty files
for i in "${ARRAY[@]}"
do
    wget -c $WEB$i -O $i
    mv $i /usr/share/texmf-texlive/tex/latex/
done

# Updating tex libs
texhash

# Getting a template
mkdir $TEMPLATE
cd $TEMPLATE
# Lets grab the template files
for i in "${ARRAY_TEMPLATE[@]}"
do
    wget -c $WEB$i -O $i
done

# Getting the logos within the template
mkdir $LOGO
cd $LOGO
# Lets grab the logo files
for i in "${ARRAY_LOGO[@]}"
do
    wget -c $WEB$TEMPLATE$i -O $i
done

# Dirty way to go back.
cd .. ; cd ..

echo 'LaTeX is installed! You can find an example here:' $TEMPLATE