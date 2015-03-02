class Animal

  def self.all_animals(arg)
    @all ||= []
    @all << arg
  end

  def self.return_animals
    puts "Returning all animals..."
    @all.each do |a|
      puts "#{a.class}: #{a.name}"
    end
  end
end

class Cat < Animal
  attr_reader :name, :age

  def initialize(args={})
    @name = args[:name]
    @age = args[:age]
    Cat.add_to_records(self)
    Animal.all_animals(self)
  end

  def self.add_to_records(cat)
    puts "Adding #{self.name} to records..."
    @all_cats ||= []
    @all_cats << cat
  end

  def self.return_records
    puts "Returning all cats..."
    @all_cats.each do |c|
      puts c.name
    end
  end
end

class Dog < Animal
  attr_reader :name

  def initialize(args={})
    @name = args[:name]
    @age = args[:age]
    Animal.all_animals(self)
  end
end

class Breed
  attr_reader :breed

  def initialize(breed)
    @breed = breed
    @all_members = []
  end

  def return_members
    puts "Returning all members of #{self.class}: #{self.breed}..."
    @all_members.each do |c|
      puts "#{c.name}"
    end
  end

  def add_animal(obj)
    @all_members << obj
    puts "Cat added to #{self.breed}"
  end

  def remove_animal(obj)
    @all_members.each.with_index do |c, i|
      if c.name == obj.name
        @all_members.delete_at(i)
        puts "#{obj.name} deleted."
        return
      end
      puts "Animal not found."
    end
  end
end

breed1 = Breed.new("Domestic")
cat1 = Cat.new(name: 'Wilbur')
cat2 = Cat.new(name: 'Marmalade', age: 12)
dog1 = Dog.new(name: 'Spot')

Animal.return_animals
Cat.return_records

breed1.add_animal(cat1)
breed1.add_animal(cat2)
breed1.return_members
breed1.remove_animal(cat1)
breed1.return_members

