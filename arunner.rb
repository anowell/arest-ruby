#!/usr/bin/env ruby

throw "Must specify EXEC_NAME" unless ENV['EXEC_NAME']

require 'json'

# Load the executor
require "./executor/#{ENV['EXEC_NAME']}.rb" # Fixed name for now

class ARunner
    # Load the executor class
    @@klass = Object.const_get(ENV['EXEC_NAME'].split('_').collect(&:capitalize).join)

    # Transform the input into args for klass.execute
    def self.run(input_str)
        begin
            # For now, lets just guess JSON...
            data = JSON.parse(input_str)

            # We could splat *data if an array, but we really need
            #   more context to the execute method signature to do that reliably
            @@klass.execute(data)
        rescue Exception => e
            # ... and fallback to raw string if JSON didn't pan out
            @@klass.execute(input_str)
        end
    end
end

# Start ARunner with the STDIN from Servur
output = ARunner.run(STDIN.read)

# Do something useful with the output, for now: STDOUT
puts "----- Executor Output -----"
puts output

# Should cleanup any cached data