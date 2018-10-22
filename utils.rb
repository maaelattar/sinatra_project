
  def mod(num)
    (num % 26 + 26) % 26
  end

  def caesar_cipher(str, num)
    str_arr = str.split('')
    num = num.to_i
    str_arr.collect! do |c|
      ascii_chr = c.ord
      if ascii_chr >= 65 && ascii_chr <= 90
        ascii_chr += num
        ascii_chr = ascii_chr <= 90 ? ascii_chr : mod(ascii_chr - 65) + 65
      elsif ascii_chr >= 97 && ascii_chr <= 122
        ascii_chr += num
        ascii_chr = ascii_chr <= 122 ? ascii_chr : mod(ascii_chr - 97) + 97
      end
      ascii_chr.chr
    end
     str_arr.join('')
  end


class Game
  attr_accessor :random_word, :guessed_word, :misses, :available_chances, :message
def initialize
  @random_word = hidden_word
  @guessed_word = dashed_word
  @misses = []
  @available_chances = 12
  @message = nil
end

    def hidden_word
        dictionary = File.read('5desk.txt')
        random_word = dictionary.scan(/\w+/).select do |word|
          word.length.between?(5, 12)
        end.sample
        random_word
    end

    def dashed_word
        ''.rjust(@random_word.length, '-')
    end

    def letter_index(letter)  
      indexes = []
      @random_word.each_char.with_index do |char, index|
          indexes.push(index) if char.casecmp?(letter)
      end
      indexes
    end

def compare(letter)
  return if @misses.include?(letter)
  @available_chances -= 1
  indexes = letter_index(letter)
  if indexes.empty?
      @misses.push(letter)
      return
  end
  indexes.each do |index|
    @guessed_word[index] = letter
  end

  end

    def failed?
      @message = "Game over you ran out of chances, the word was #{@random_word}"
      @available_chances == 0
    end

    def announce_winner
      @message = 'Congratulatoins you have guessed it all right'
      @guessed_word.casecmp?(@random_word)
    end

    def game_end?
      announce_winner || failed?
    end
end
