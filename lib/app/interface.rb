class Interface
    attr_accessor :user
    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new #This line initializes the prompt for user.
    end

    def welcome
        system 'clear'
        puts "Hi, Welcome to the home of Elephant Healing and Care Center/Sanctionary"
        sleep(1)

        @prompt.select("How may we help you?") do |menu|
            menu.choice "🐘  Login", -> { User.login } # Below. Line 23
            menu.choice "🐘  Create a New Account", -> { User.create_new_user } # This will redirect you to the create_new_user method in the User class.
            menu.choice "🐘  Exit", -> { User.goodbye } # This will close the app
        end
    end

end

# The welcome method will puts out the message on like 11, 
# then will prompt the user to make a choice.
# If the user picks to "Login", this will then direct them to the login method thats in the User class.

# The login method looks like:

# From the User class
# ---------------------
# def self.login
#     puts "Enter your account information"
#     puts "Username: "
#     user_name = gets.chomp
#     pass_word = @@prompt.mask("Password: ")
#     User.find_by(username: user_name, password: pass_word) # This will search in the users table where username and password matches whats in the username and password in the table.
# end
# ---------------------

# The login method prompts the user to enter the username and a password.

# ------------------------
# this is all the login method does
# ******************************************************************************************************************************************************************************************************************************************

# After the user enters the username and password, 
# The valadate method will run next because of the order that our run.rb

# def self.validation(user)
#     if user.name != "Exit"
#         puts "Welcome, #{user.name}!"
#         sleep(1)
#         #should return main_menu method.
#         Listing.main_menu(user) # after like 51, the main_menu method will pop up form Listing class.
#     else 
#         #dead end 
#     end  
# end
# ************************************************************************************************************************************************************************************************************************************

# Here is the main_menu from the Listing class.

# def self.main_menu(user)
#     system 'clear'
#     user.reload
#     puts "--- Main Menu ---"
#     @@prompt.select("What would you like to do? 🐘") do |menu|
#         menu.choice "🐘  Check My Balance", -> { user.show_my_balance(user) } # If the user picks this choice, then this will redirect them to the show_my_balance method thats in the User class. so "user.show_my_balance(user)" The "user" before the .show_my_balance is from line 63. show_my_balance is the method and the method takes in one argument. that argument is the user after the show_my_balance.
#         menu.choice "🐘  See My Elephant(s)", -> { user.my_elephant } # If the user picks this choice, then this will redirect them to the my_elephant method thats in the User class. so the "user" before the my_elephant is from line 63. .my_elephant is the method dones't take in an argument.
#         menu.choice "🐘  See All Listings That Are Available", -> { Listing.display_all_listings(user) } # If the user picks this choice, then this will redirect them to the display_all_listings method in the Listing class. The "user" in the Listing.display_all_listings(user) is from 63. Takes in an argument.
#         menu.choice "🐘  See My Order History", -> { user.order_history } # If the user picks this choice, then this will redirect them to the order_history method in the User class.
#         menu.choice "🐘  See My Account Settings", -> { User.account_settings(user) } # If the user picks this choice, then this will redirect them to the account_setting method in User class.
#         menu.choice "🐘  Exit", -> { puts "Have a Nice Day!" } # If the user picks this choise, It will close the app.
#     end
# end