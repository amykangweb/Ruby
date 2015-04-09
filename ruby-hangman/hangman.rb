# Translate treehouse java hangman program into ruby

class Hangman

  def self.start_game(answer)
    game = Game.new(answer)
    prompter = Prompter.new
    prompter.play(game)
  end
end

class Prompter

  def play(game)
    while game.remaining_tries > 0 && !game.is_solved
      self.display_progress(game)
      self.prompt_guess(game)
    end
    if game.is_solved
      puts "Congratulations, you won with #{game.remaining_tries} tries remaining."
    else
      puts "Bummer the word was #{game.answer}. :("
    end
  end

  def prompt_guess(game)
    is_valid = false
    while !is_valid
      print "Please enter a guess: "
      guess = STDIN.gets.chomp
      begin
        is_hit = game.not_empty(guess)
        is_valid = true
      rescue ArgumentError => e
        puts e.message + " Please try again."
      end
    end
    is_hit
  end

  def display_progress(game)
    result = game.current_progress
    tries = game.remaining_tries
    puts "You have #{tries} tries left to solve: #{result}"
  end
end

class Game
  attr_reader :answer

  MAX_MISSES = 7

  def initialize(answer)
    @answer = answer
    @hits = ""
    @misses = ""
  end

  def validate_guess(guess)
    if guess =~ /\A[-+]?[0-9]+\z/
        raise ArgumentError.new("A letter is required.")
    end
    if @misses.index(guess) != nil || @hits.index(guess) != nil
        raise ArgumentError.new("#{guess} has already been guessed.")
    end
    guess
  end

  def not_empty(guess)
    if guess.empty?
        raise ArgumentError.new("No letter found.")
    end
    self.check_answer(guess[0])
  end

  def check_answer(guess)
    guess = self.validate_guess(guess)
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

  def remaining_tries
    MAX_MISSES - @misses.length
  end

  def is_solved
    self.current_progress.index('_') == nil
  end
end

secret_word = ARGV.first
if secret_word == nil
  print "Please enter a word."
  exit(0)
end
Hangman.start_game(secret_word)
