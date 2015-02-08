class CountByLetter
  def self.execute(text)
    h = {}
    text.each_char do |c|
        lc = c.downcase
        if lc >= "a" && lc <= "z"
            h[lc] ||= 0
            h[lc] += 1
        end
    end
    h
  end
end