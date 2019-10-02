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

    def self.account_settings(user)
        @@prompt.select("What would you like to change?") do |as|
            as.choice "Change Username", -> { user.change_username }
            as.choice "Change Password", -> { user.change_password }
            as.choice "Go Back to Main Menu...", -> { Listing.main_menu(user)}
        end
    end

    def change_username
        puts "Enter a new username: "
        new_user_name_change = gets.chomp
        self.update(username: new_user_name_change)
        save
        puts "Your Username is updated"
        @@prompt.select("<--------->") do |sub|
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(self)}
        end
    end

    def change_password
        puts "Enter a new Password: "
        new_pass_word_change = gets.chomp
        self.update(password: new_pass_word_change)
        puts "Your password is updated"
        @@prompt.select("<--------->") do |sub|
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(self)}
        end
    end

    def my_elephant(user)
        if self.elephants == []
            puts "Sorry, you don't have an Elephant!"
            @@prompt.select("<--------->") do |sub|
                sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)}
            end
        else
            # elephants_name = self.elephants.map do
            #     |elep| elep.name
            # end
            elephants_name = self.alt_elephants.map(&:name)

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
                sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)}
            end
        end
    end

    def alt_elephants
        elephants_arr = []
        
        listings_related_to_user = Listing.all.select{|listing|
        listing.user_id == self.id}.select{|listing|     
            listing.status == "transaction"
        }
    
        elephants_id_list = listings_related_to_user.map{|listing| listing.elephant_id}
    
        elephants_id_list.each do |id|
            elephants_arr << Elephant.all.find_by(id: id)
        end

        return elephants_arr
    
    end

    #The Method in above this line is created to be alternative method for a ActiveRecord Method .elephants which is in the User Class.

    def show_my_balance(user)
        puts "This is your balance: $#{self.balance}"
        @@prompt.select("<--------->") do |sub|
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)}
        end
    end

    def valid_money?(listing)
        if self.balance >= listing.price
            return true
        else
            return false
        end
    end

    def buy_elephant(listing)
        if listing.status == "open" && self.valid_money?(listing) 
            elephant = Elephant.all.find_by(id: listing.elephant_id)
            upd = self.balance - listing.price
            upd2 = User.all.find_by(id: listing.user_id).balance + listing.price
            User.all.find_by(id: listing.user_id).update(balance: upd2)
            self.update(balance: upd)
            Listing.create({user_id: self.id,elephant_id: elephant.id,price: listing.price,title: "*****",status: "transaction"})
            listing.update(status: "closed transaction")
            # binding.pry
            puts "Congrats! You have owned an 🐘💩. We hope to see you around!"
            sleep(3)
            Listing.main_menu(self)
        else
            puts "Sorry, you don't have enough 💰  or the listing that you trying to reach is not available!"
        end
    end

end