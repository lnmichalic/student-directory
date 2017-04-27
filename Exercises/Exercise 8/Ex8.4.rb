#method to input the students which prompts user for entry, adds name as part
# of a hash with default cohort november, to an array of hashes unless user
#hits return twice, ending entry
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
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
  puts "Please input the initial letter of names to print:"
  initial = gets.chomp
  while students.count != index  do
    if students[index][:name][0].downcase == initial.downcase && students[index][:name].length < 12 then
      puts "#{index+1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"
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
