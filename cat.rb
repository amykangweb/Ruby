class Animal

  attr_reader :name, :age

  def initialize(args={})
    @name = args[:name]
    @age = args[:age]
    self.class.add_to_records(self)
    Animal.all_animals(self)
  end

  # Add and Return members of particular species

  def self.add_to_records(obj)
    puts "Adding #{obj.name} to #{self}s..."
    @all_animal ||= []
    @all_animal << obj
  end

  def self.return_records
    puts "Returning all #{self}s..."
    @all_animal.each do |c|
      puts c.name
    end
  end

  # Methods that belong to Animal only

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
end

class Dog < Animal
end

class Breed
  attr_reader :breed

  def initialize(breed)
    @breed = breed
    @all_members = []
  end

  # Add and Return members of specific Breed"

  def return_members
    puts "Returning all members of #{self.class}: #{self.breed}..."
    @all_members.each do |c|
      puts "#{c.name}"
    end
  end

  def add_animal(obj)
    @all_members << obj
    puts "#{obj.name} added to #{self.breed}"
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
Dog.return_records

breed1.add_animal(cat1)
breed1.add_animal(cat2)
breed1.return_members
breed1.remove_animal(cat1)
breed1.return_members

