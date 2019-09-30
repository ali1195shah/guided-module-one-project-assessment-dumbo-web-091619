class Interface
    attr_accessor :user
    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new #This line initializes the prompt for user.
    end

end