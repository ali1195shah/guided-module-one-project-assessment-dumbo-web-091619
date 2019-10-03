require_relative '../config/environment'

interface = Interface.new() # This is the first thing that runs when you start the app.
user = interface.welcome()

while user.nil?
    user = interface.welcome()
end

User.validation(user)



binding.pry
0