# arest-ruby
Proof-of-concept ruby runner for [arest](https://github.com/anowell/arest)

# Testing standalone

    $ ln -s examples/count_by_letter executor
    $ echo "hello world" | EXEC_NAME="count_by_letter" ./arunner.rb
    ----- Executor Output -----
    {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}

# Testing container
You must bind mount the executor to /home/arunner/executor/ and set EXEC_NAME

    $ docker build -t arest-ruby .
    $ docker run -p 8080:8080 -e "EXEC_NAME=count_by_letter" -v `pwd`/examples/count_by_letter:/home/arunner/executor:ro arest-ruby
    $ curl -s localhost:8080/data -XPOST -d"hello world"
    /bin/arunner.rb output: ----- Executor Output -----
    {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}
