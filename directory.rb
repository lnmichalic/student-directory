require 'csv'

# Constants
@students = []
@lw = 50 # short for line width to make style globally consistent

#Student Class
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

  def initialize(name, cohort = :november)
    @name = name
    @cohort = cohort
    @age = "rude to ask"
    @nationality = :global_human
    @hobbies = "breathing"
  end

  def self.cohorts
    @@COHORTS
  end

  def hash
    {name: name, cohort: cohort, age: age, nationality: nationality, hobbies: hobbies}
  end

end

# Main Menu Loop
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp.downcase)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list of a file"
  puts "Optional Features:"
  puts "5. Show all students starting with initial of choice"
  puts "6. Print list of student by cohort"
  puts "7. Sort students by cohort"
  puts "9. Exit"
end

def process(selection)
  puts "Option '#{selection}' has been selected"
  case selection
  when "1", "input"
    input_students
  when "2", "show"
    build_list
  when "3", "save"
    filename = prompt_for_file_path
    puts "You're saving to '#{filename}'"
    save_students(filename)
  when "4", "load"
    filename = prompt_for_file_path
    puts "You're loading from '#{filename}'"
    load_students(filename)
  when "5", "initial"
    build_list("initial")
  when "6", "cohort"
    build_list("cohort")
  when "7", "sort"
    sorts_cohort
  when "9", "exit"
    exit
  else puts "Invalid input, try again"
  end
  puts "Option '#{selection}' has been completed"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "Which cohort is #{name} in?"
    user_input = STDIN.gets.chomp
    until Student.cohorts.include?(user_input.downcase.to_sym) do
      break if user_input.empty?
      puts "Please enter a valid cohort."
      user_input = STDIN.gets.chomp
    end
    cohort = user_input
    add_student(name, cohort)
    puts "Now we have #{@students.count} student#{pluralize(@students.count)}"
    name = STDIN.gets.chomp
  end
  if @students.empty?
    puts "Please enter at least one student"
    input_students
  end
end

def add_student(name, cohort)
  @students << Student.new(name, cohort.to_sym)
end

def build_list(option = "default")
  print_header
  print_students_list if option == "default"
  print_students_list_by_initial if option == "initial"
  print_student_by_cohort if option == "cohort"
  print_footer
end

def print_header
  puts "The Students of Makers Academy".center(@lw)
  puts "-"*@lw
end


def print_students_list
  index = 0
  while @students.count != index  do
    puts "#{index+1}.".ljust(@lw/6) + " #{@students[index].name}".center(@lw/2) + "(#{@students[index].cohort.capitalize} cohort)".rjust(@lw/3)
    index+=1
  end
end

def print_students_list_by_initial
  puts "Please input the initial letter of names to print:"
  initial = STDIN.gets.chomp.downcase
  @students.each do |student|
    if student.name[0].downcase == initial  then
      puts "#{student.name}".ljust(@lw/2) + "(#{student.cohort.capitalize} cohort)".rjust(@lw/2)
    else
    end
  end
end

def sorts_cohort
  @students.sort_by!{|student| student.cohort}
end

def print_student_by_cohort
  list_to_print =[]
  puts "Enter cohort to print:"
  user_input = STDIN.gets.chomp.downcase.to_sym
  @students.map{ |student| list_to_print << student.name if student.cohort == user_input }
  puts list_to_print
end

def pluralize(n)
  n == 1? "" : "s"
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{pluralize(@students.count)}".center(@lw)
end

def prompt_for_file_path
  default_file = "students.csv"
  puts "Please specify the file destination, if blank or not valid defaults to '#{default_file}'"
  file_path = STDIN.gets.chomp
  file_path = default_file if file_path.empty? || !file_path.end_with?(".csv")
  file_path
end

def save_students(filename)
  CSV.open(filename, "w") do |line|
    @students.each do |student|
      line << [student.name, student.cohort]
    end
  end
end

def load_students(filename)
  CSV.foreach(filename) do |line|
    name, cohort = line
    add_student(name, cohort)
  end
end

#initial method to load students from external file
def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from '#{filename}'"
  else
    puts "Sorry, '#{filename}' doesn't exist."
    exit
  end
end

try_load_students
interactive_menu



# Test calls
