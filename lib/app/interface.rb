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
            menu.choice "🐘  Login", -> { User.login }
            menu.choice "🐘  Create a New Account", -> { User.create_new_user }
            menu.choice "🐘  Exit", -> { User.goodbye }
        end
    end

end