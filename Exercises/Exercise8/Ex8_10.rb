#Global variable storing an array of all the Student instances
@students = []

#Student class initialized with default values other than name and cohort which is checked against possible cohorts
class Student

  @@COHORTS = {
    :january    => "january",
    :february   => "february",
    :march      => "march",
    :april      => "april",
    :may        => "may",
    :june       => "june",
    :july       => "july",
    :august     => "august",
    :september  => "september",
    :october    => "october",
    :november   => "november",
    :december   => "december"
  }

  attr_accessor :name, :cohort, :age, :nationality, :hobbies

  def initialize(name)
    @name = name
    # self.cohort = COHORTS[:cohort]
    @age = "rude to ask"
    @nationality = :global_human
    @hobbies = "breathing"
  end

  def self.cohorts
    @@COHORTS
  end
end


#method to input the students which prompts user for entry, adding name creates an object
# and then asks for cohort, if not included, throws an error message, and other attributes
# of the object are currently set to default values,
# All objects are put into an array of objects(Student). unless user hits return twice, ending entry
def input_students
  students = []
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.strip
  while !name.empty? do
    student = Student.new(name)
    students << student
    puts "Which cohort is #{name} in?"
    user_input = gets.strip
    #   Student.cohorts.include?(user_input.to_sym) ? student.cohort = user_input : puts "Please enter a valid cohort."
    until Student.cohorts.include?(user_input.downcase.to_sym) do
      break if user_input.empty?
      puts "Please enter a valid cohort."
      user_input = gets.strip
    end
    student.cohort = user_input

    puts "Now we have #{students.count} student#{pluralize(students.count)}"
    name = gets.strip
  end
  @students = students
  students
end

#prints top of the list
def print_header
  puts "The students of Makers Academy"
  puts "------------"
end


#prints a list of students, only beginning with the initial letter determined
#by user, and only names that are less than 12 characters. Also prints the indices
#of names in the entire list (not of the list outputted) (to be fixed later?)
def print(students)
  index = 0
  lineWidth = 30
  puts "Please input the initial letter of names to print:"
  initial = gets.strip
  while students.count != index  do
    if students[index].name.to_s[0].downcase == initial.downcase && students[index].name.to_s.length < 12 then
      #outputs line with {index. name (cohort)} left, center and right justified for each element. current ratios are set with lineWidth=30
      puts "#{index+1}.".ljust(lineWidth/6) + " #{students[index].name}".center(lineWidth/2) + "(#{students[index].cohort.capitalize} cohort)".rjust(lineWidth/3)
    else
    end
    index+=1
  end
end

def sorts_cohort(students)
  students.sort_by!{|student| student.cohort}
end

#prints all students in cohort input by user, no styling as print(students) method, create a loop to check if proper cohort has been input
def print_student_by_cohort(students)
  list_to_print =[]
  puts "Enter cohort to print:"
  user_input = gets.strip
  students.map{|student| list_to_print << student.name if student.cohort == user_input.downcase}
  puts list_to_print
end

#method to pluralize words in strings based on arguement provided (currently only changing student/s based on student.count)
def pluralize(n)
  n == 1? "" : "s"
end


#prints how many students there are altogether (update with number of students
#outputted to stdout?)
def print_footer(students)
  puts "Overall, we have #{students.count} great student#{pluralize(students.count)}"
end

#method to call all methods and output the list in entirety
def build_list
  students = input_students
  print_header
  # print(students)
  print_footer(students)
  print_student_by_cohort(students)
end

build_list
# Testing calls
# puts @students[0].name
# puts @students[0].age
# puts @students[0].cohort
# puts @students[0].nationality
# puts @students[0].hobbies

# print_student_by_cohort(students)
