class User < ActiveRecord::Base
    has_many :listings
    has_many :elephants, through: :listings
    @@prompt = TTY::Prompt.new

    def self.login
        puts "Enter your account information"
        puts "Username: "
        user_name = gets.chomp
        pass_word = @@prompt.mask("Password: ")
        User.find_by(username: user_name, password: pass_word)
    end

    def self.validation(user)
        if user.name != "Exit"
            puts "Welcome, #{user.name}!"
            sleep(1)
            #should return main_menu method.
            Listing.main_menu(user)
        else 
            #dead end 
        end  
    end

    def self.goodbye
        sleep(1)
        puts "😢 Goodbye..."
        User.find_by(name: "Exit")
    end

    def self.create_new_user
        puts "Username: "
        new_user_name = gets.chomp

        puts "First Name: "
        new_first_name = gets.chomp

        puts "Password: "
        new_pass_word = gets.chomp

        puts "How much money do you want to transfer into your Elephant account? "
        new_balance = gets.chomp

        User.create(name: new_first_name, username: new_user_name, password: new_pass_word)
    end

    def self.account_settings
        
    end

    def my_elephant
        # elephants_name = self.elephants.map do
        #     |elep| elep.name
        # end
        elephants_name = self.elephants.map(&:name)

        chosen_elephant = @@prompt.select("Here is the list of your Elephant(s): ", elephants_name)
        elephant_obj = Elephant.all.find{|elephant| elephant.name == chosen_elephant}

        puts "Name: #{elephant_obj.name}"
        puts "From: #{elephant_obj.affiliation}"
        puts "Date of Birth: #{elephant_obj.dob}"
        puts "Species: #{elephant_obj.species}"
        puts "Gender: #{elephant_obj.gender}"
        puts "About: #{elephant_obj.note}"
        puts "Bought for: $#{elephant_obj.worth}"

        @@prompt.select("<--------->") do |sub|
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu}
        end
    end


end