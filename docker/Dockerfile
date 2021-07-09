FROM golang

RUN git clone https://github.com/nicolasdilley/ase-gomela
RUN	go get
RUN	go install
RUN	go build
RUN	./ase-gomela source
