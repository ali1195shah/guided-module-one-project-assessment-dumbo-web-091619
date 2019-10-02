require 'rubygems' # Just in case.
require 'rest-client'
require 'json'

#This destroy_all methods for cleaning up the database.
Elephant.destroy_all
User.destroy_all
Listing.destroy_all

# require 'pry'
User.create({name: "Elephant Sanctionary", username: "elephant_sanc", password: "elephant", balance: 1_000 })
User.create({name: "Ali", username: "FlameAceAli", password: "123456", balance: 429_850})
User.create({name: "Emirhan", username: "emskaplann", password: "654321", balance: 310_000})
User.create({name: "Exit", username: "exit_person", password: "123", balance: 0})

def insert_elephant
     response_str = RestClient.get('https://elephant-api.herokuapp.com/elephants') # This is the get the ele information from the web page.
     response_arr = JSON.parse(response_str) # Json viewer. turns ulgy things into good looking things.

     response_arr.each do |elephant|
        month= rand(1..12)
        year= rand(1950..2018)
        date= rand(1..30)
        Elephant.create(
            {
            name: elephant["name"],
            affiliation: elephant["affiliation"],
            species: elephant["species"],
            gender: elephant["sex"],
            dob: "#{month}/#{date}/#{year}",
            worth: rand(13_000..133_200),
            note: elephant["note"]
            }
        )
        # binding.pry
     end
end

def insert_listing
    Elephant.all.each do |elephant|
        Listing.create(
            {
                user_id: User.all.first.id,
                elephant_id: elephant.id,
                price: elephant.worth,
                title: elephant.name,
                status: "transaction"
             }
                    ) 
    end
    Elephant.all.each do |elephant|
        Listing.create(
            {
                user_id: User.all.first.id,
                elephant_id: elephant.id,
                pre_user_id: 0,
                price: elephant.worth,
                title: elephant.name,
                status: "open"
             }
                    ) 
    end
end

insert_elephant()
# There are a total of 47 elephant. SHIT BRO!

insert_listing()
# we should write this method second. because we need elephants first!

