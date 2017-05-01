require 'csv'

@students = []
@lw = 50 # short for line width to make style globally consistent

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

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp.downcase)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list of students.csv"
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

def build_list
  print_header
  # print_student_by_cohort(@students)
  print_students_list
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
  students = @students
  index = 0
  puts "Please input the initial letter of names to print:"
  initial = STDIN.gets.chomp
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
  user_input = STDIN.gets.chomp
  students.map{ |student| list_to_print << student.name if student.cohort == user_input.downcase}
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
