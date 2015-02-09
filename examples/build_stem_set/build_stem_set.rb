require 'stemmify'
require 'set'

class BuildStemSet
  def self.execute(text)
    stems = text.split(/\W+/).reduce(Set.new) do |stems, word|
        stems << word.stem
    end
    stems.to_a
  end
end