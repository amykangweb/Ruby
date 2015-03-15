# Translating java hangman program into ruby

class Hangman

  def self.prompt_guess(answer)
    print "Please enter a guess: "
    guess = gets.chomp
    guess = guess[0]
    game = Game.new(answer)
    result = game.check_answer(guess)
    Prompter.guess_result(result)
  end
end

class Prompter

  def self.guess_result(result)
    if result == true
      puts "We got a hit!"
    else
      puts "Whoops that's a miss!"
    end
  end
end

class Game

  def initialize(answer)
    @answer = answer
    @hits = ""
    @misses = ""
  end

  def check_answer(guess)
    is_hit = @answer.index(guess) != nil
    if is_hit
      @hits << guess
      puts @hits
    else
      @misses << guess
      puts @misses
    end
    return is_hit
  end
end

Hangman.prompt_guess("treehouse")
