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
        
    end

    def self.account_settings
        
    end


end