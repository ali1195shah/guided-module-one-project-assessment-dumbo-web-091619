require_relative '../config/environment'

<<<<<<< HEAD
puts "hello world" # Hi
=======
interface = Interface.new()
user = interface.welcome()

while user.nil?
    user = interface.welcome()
end

User.validation(user)



binding.pry
0
>>>>>>> 35cb2254485b72eb9506ddc909d5a996b533912d
