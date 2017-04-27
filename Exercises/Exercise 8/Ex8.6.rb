#Global variable storing an array of all the Student instances
@students = []

#Student class initialized with default values other than name
class Student

  attr_accessor :name, :cohort, :age, :nationality, :hobbies

  def initialize(name)
    @name = name
    @cohort = :november
    @age = "rude to ask"
    @nationality = :global_human
    @hobbies = "breathing"
  end
end


#method to input the students which prompts user for entry, adds name as part
# of a hash with default cohort november and other attributes set to default values,
# to an array of objects(Student) unless user hits return twice, ending entry
def input_students
  students = []
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    students << Student.new(name)
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  @students = students
  students
end

#prints top of the list
def print_header
  puts "The students of my cohort at Makers Academy"
  puts "------------"
end

#prints a list of students, only beginning with the initial letter determined
#by user, and only names that are less than 12 characters. Also prints the indices
#of names in the entire list (not of the list outputted) (to be fixed later?)
def print(students)
  index = 0
  lineWidth = 30
  puts "Please input the initial letter of names to print:"
  initial = gets.chomp
  while students.count != index  do
    if students[index].name.to_s[0].downcase == initial.downcase && students[index].name.to_s.length < 12 then
      #outputs line with {index. name (cohort)} left, center and right justified for each element. current ratios are set with lineWidth=30
      puts "#{index+1}.".ljust(lineWidth/6) + " #{students[index].name}".center(lineWidth/2) + "(#{students[index].cohort.capitalize} cohort)".rjust(lineWidth/3)
    else
    end
    index+=1
  end
end

#prints how many students there are altogether (update with number of students
#outputted to stdout?)
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

#method to call all methods and output the list in entirety
def build_list
  students = input_students
  print_header
  print(students)
  print_footer(students)
end

build_list
# Testing calls
# puts @students[0].name
# puts @students[0].age
# puts @students[0].cohort
# puts @students[0].nationality
# puts @students[0].hobbies
