# My solution for Ruby Quiz #2 Secret Santas
# http://rubyquiz.com/quiz2.html
# Program re-shuffles people until everyone has a secret santa.
#
# Luke Skywalker   <luke@theforce.net>
# Leia Skywalker   <leia@therebellion.org>
# Toula Portokalos <toula@manhunter.org>
# Gus Portokalos   <gus@weareallfruit.net>
# Bruce Wayne      <bruce@imbatman.com>
# Virgil Brigman   <virgil@rigworkersunion.org>
# Lindsey Brigman  <lindsey@iseealiens.net>

class Persons
  attr_reader :first, :last, :email
  attr_accessor :taken

  @@all = []
  @@mixed = []
  @@pairs = []

  def initialize(first, last, email)
    @first = first
    @last = last
    @email = email
    @taken = false
    Persons.add_all(self)
  end

  def self.add_all(person)
    @@all << person
  end

  def last_same?(arg)
    self.last == arg.last
  end

  def self.mix_bag
    @@all.each do |person|
      @@mixed = @@all.shuffle
      Persons.pair_up(person)
    end
  end

  def self.pair_up(person)
    @@mixed.each do |santa|
      unless person.last_same?(santa) || santa.taken == true
        @@pairs << [person, santa]
        puts "#{person.first}'s secret santa is #{santa.first}."
        santa.taken = true
        return
      end
    end
    puts "Unable to find santa for #{person.first}!"
    puts "Re-shuffling!"
    @@all.each { |person| person.taken = false }
    Persons.mix_bag
  end
end

obj1 = Persons.new("Luke", "Skywalker", "luke@mail.com")
obj2 = Persons.new("Leia", "Skywalker", "leia@mail.com")
obj3 = Persons.new("Toula", "Portokalos", "toula@mail.com")
obj4 = Persons.new("Gus", "Portokalos", "gus@mail.com")
obj5 = Persons.new("Bruce", "Wayne", "bruce@mail.com")
obj6 = Persons.new("Virgil", "Brigman", "virgil@mail.com")
obj7 = Persons.new("Lindsey", "Brigman", "lindsey@mail.com")
Persons.mix_bag

