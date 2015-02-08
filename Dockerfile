FROM arest

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.2 && \
    rm -rf /var/lib/apt/lists/*

COPY arunner.rb /bin/arunner.rb

WORKDIR /home/arunner
USER arunner
CMD ["/bin/arunner.rb"]