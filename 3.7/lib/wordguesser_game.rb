
class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    if(letter == nil or letter == "" or not letter.match?(/[A-Za-z]/)) then raise ArgumentError end
    letter = letter.downcase
    if(@word.include?(letter))
      if(@guesses.include?(letter))
        return false
      else
        @guesses += letter
      end
    elsif(not @wrong_guesses.include?(letter))
      @wrong_guesses += letter
    else
      return false
    end
  end

  def word_with_guesses()
    res = ""
    @word.each_char do |char|
      if(guesses.include?(char))
        res += char
      else
        res += "-"
      end
    end
    res
  end

  def check_win_or_lose()
    if(not word_with_guesses.include?("-")) then return :win end
    if(wrong_guesses.length >= 7) then return :lose end
    :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
