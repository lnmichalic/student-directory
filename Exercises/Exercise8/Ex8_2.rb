#method to input all the students in
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "------------"
end

def print(students)
  #prompts user to input a letter
  puts "Please input the initial letter:"
  initial = gets.chomp
  students.each_with_index  do |student, index|
    if student[:name][0].downcase == initial.downcase
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    else
    end
  end
end

# def print(students)
#   students.each_with_index  do |student, index|
#     puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
#   end
# end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
