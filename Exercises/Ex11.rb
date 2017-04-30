@students = []
@lw = 60 # short for line width to make style globally consistent

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

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1" || "input" then input_students   # input the students
    when "2" || "show"  then build_list       # print the list of students
    when "3" || "save"  then save_students
    when "9" || "exit"  then exit             # exits the program
    else puts "Invalid input, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    student = Student.new(name)
    @students << student
    puts "Which cohort is #{name} in?"
    user_input = gets.chomp
    until Student.cohorts.include?(user_input.downcase.to_sym) do
      break if user_input.empty?
      puts "Please enter a valid cohort."
      user_input = gets.chomp
    end
    student.cohort = user_input
    puts "Now we have #{@students.count} student#{pluralize(@students.count)}"
    name = gets.chomp
  end
  if @students.empty?
    puts "Please enter at least one student"
    input_students
  end
end

def build_list
  print_header
  # print_student_by_cohort(@students)
  print_students_list
  print_footer
end

def print_header
  puts "The students of Makers Academy".center(@lw)
  puts "------------------------------".center(@lw)
end


def print_students_list
  students = @students
  index = 0
  puts "Please input the initial letter of names to print:"
  initial = gets.chomp
  while students.count != index  do
    if students[index].name.to_s[0].downcase == initial.downcase && students[index].name.to_s.length < 12 then
      puts "#{index+1}.".ljust(@lw/6) + " #{students[index].name}".center(@lw/2) + "(#{students[index].cohort.capitalize} cohort)".rjust(@lw/3)
    else
    end
    index+=1
  end
  @students = students
end

def sorts_cohort(students)
  students.sort_by!{|student| student.cohort}
end

def print_student_by_cohort(students)
  list_to_print =[]
  puts "Enter cohort to print:"
  user_input = gets.chomp
  students.map{ |student| list_to_print << student.name if student.cohort == user_input.downcase}
  puts list_to_print
end

def pluralize(n)
  n == 1? "" : "s"
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{pluralize(@students.count)}".center(@lw)
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student.name, student.cohort]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end


interactive_menu



# Test calls
