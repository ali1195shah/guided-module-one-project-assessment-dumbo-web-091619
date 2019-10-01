require_relative '../config/environment'

interface = Interface.new()
user = interface.welcome()

while user.nil?
    user = interface.welcome()
end

User.validation(user)



binding.pry
0