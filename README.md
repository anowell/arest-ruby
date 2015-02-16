# servur-ruby
Proof-of-concept ruby runner for [servur](https://github.com/anowell/servur)

# Basic idea

- Servur is a simple web service in a container that takes data POSTed to /data and hands it to a "runner" as stdin
- arunner.rb is a ruby implementation of a "runner" that does some basic transformation of stdin data and calls any arbitrary ruby "executor" with it
- A ruby "executor" is any class that implements `self.execute(input)`
  - the filename should currently be the snake_case name of the class which should be CamelCased
  - `input` is currently a ruby Hash for JSON data, otherwise simply a raw string

# Usage

To run the [anowell/servur-ruby](https://registry.hub.docker.com/u/anowell/servur-ruby/) docker image, you must bind mount an executor to /home/arunner/executor/ and set EXEC_NAME

    $ export EXEC_NAME=count_by_letter
    $ docker run -p 8080:8080 -e EXEC_NAME -v `pwd`/examples/$EXEC_NAME:/home/arunner/executor:ro anowell/servur-ruby
    $ curl -s localhost:8080/data -XPOST -d"hello world"
    /bin/arunner.rb output: ----- Executor Output -----
    {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}

Any dependencies specified in a Gemfile will be installed when the container first starts. See [build_stem_set](examples/build_stem_set) for an example with dependencies.

# Testing standalone

Put an example in the executor directory (relative to cwd), set EXEC_NAME, and pipe data into arunner.rb

    $ ln -s examples/count_by_letter executor
    $ echo "hello world" | EXEC_NAME="count_by_letter" ./arunner.rb
    ----- Executor Output -----
    {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}
