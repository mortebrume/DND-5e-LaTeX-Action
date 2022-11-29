# Container image that runs your code
FROM ghcr.io/xu-cheng/texlive-full:latest

WORKDIR /root

COPY submodules/dnd /root/texmf/tex/latex/dnd/

# Install all LaTeX packages listed in the dnd sty
RUN tlmgr install `cat /root/texmf/tex/latex/dnd/packages.txt | grep "^[^#]"`

RUN tlmgr install \
    enumitem \
    gensymb \
    hang \
    numprint \
    tcolorbox \
    environ \
    pdfcol \
    tocloft \
    titlesec \
    lettrine \
    minifp \
    kpfonts-otf

COPY entrypoint.sh entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["entrypoint.sh"]
