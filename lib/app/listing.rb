class Listing < ActiveRecord::Base
    belongs_to :user
    belongs_to :elephant
    #If we want to use Prompt, we should write the code below that line.
    @@prompt = TTY::Prompt.new

    def self.main_menu(user)
        puts "--- Main Menu ---"
        @@prompt.select("What would you like to do? 🐘") do |menu|
            menu.choice "🐘  Check Balance", -> { "This is your balance: $#{user.balance}" }
            menu.choice "🐘  My Elephant(s)", -> { user.my_elephant }
            menu.choice "🐘  Listings", -> { Listing.display_listing_section }
            menu.choice "🐘  Order History", -> { Listing.order_history }
            menu.choice "🐘  Account Settings", -> { User.account_settings }
        end
    end

    

    def self.display_listing_section
        
    end

    def self.order_history
        
    end

end