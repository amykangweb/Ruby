# Translate java hangman program into ruby

class Hangman

  def self.start_game(answer)
    game = Game.new(answer)
    prompter = Prompter.new
    prompter.display_progress(game)
    result = prompter.prompt_guess(game)
    Hangman.guess_result(result)
    prompter.display_progress(game)
  end

  def self.guess_result(result)
    if result == true
      puts "We got a hit!"
    else
      puts "Whoops that's a miss!"
    end
  end
end

class Prompter

  def prompt_guess(game)
    print "Please enter a guess: "
    guess = gets.chomp
    guess = guess[0]
    game.check_answer(guess)
  end

  def display_progress(game)
    result = game.current_progress
    puts "Try to solve: #{result}"
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
    else
      @misses << guess
    end
    return is_hit
  end

  def current_progress
    progress = ''
    @answer.chars.to_a.each do |letter|
      display = '_'
      if @hits.index(letter) != nil
        display = letter
      end
      progress += display
    end
     return progress
  end
end

Hangman.start_game("treehouse")
