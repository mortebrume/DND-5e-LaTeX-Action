# Container image that runs your code
FROM ghcr.io/xu-cheng/texlive-full:latest

WORKDIR /root

RUN apk update
RUN apk add git

RUN git clone https://github.com/matsavage/DND-5e-LaTeX-Action.git
WORKDIR /root/DND-5e-LaTeX-Action
RUN git submodule init
RUN git submodule update
RUN mkdir -p /root/texmf/tex/latex
RUN mv submodules/dnd /root/texmf/tex/latex/

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

COPY entrypoint.sh /root/
WORKDIR /root

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/root/entrypoint.sh"]
