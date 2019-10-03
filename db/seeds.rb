require 'rubygems' # Just in case.
require 'rest-client' # Used for APIs
require 'json' # Used for APIs

#This destroy_all methods for cleaning up the database.
Elephant.destroy_all # The table Elephant(these are classes in the files that are inside the app folder.) becomes empty/distroyed so the table doesnt have DUPES.
User.destroy_all     # The table User(these are classes in the files that are inside the app folder.) becomes empty/distroyed so the table doesnt have DUPES.
Listing.destroy_all  # The table Listing(these are classes in the files that are inside the app folder.) becomes empty/distroyed so the table doesnt have DUPES.

# require 'pry'
User.create({name: "Elephant Sanctionary", username: "elephant_sanc", password: "elephant", balance: 1_000 }) # Based on what your table rows are, you add the entries here
User.create({name: "Ali", username: "FlameAceAli", password: "123456", balance: 429_850}) # Based on what your table rows are, you add the entries here
User.create({name: "Emirhan", username: "emskaplann", password: "654321", balance: 310_000})# Based on what your table rows are, you add the entries here
User.create({name: "Exit", username: "exit_person", password: "123", balance: 0}) # This is erelavent.

def insert_elephant
     response_str = RestClient.get('https://elephant-api.herokuapp.com/elephants') # This is the get the ele information from the web page.
     response_arr = JSON.parse(response_str) # Json viewer. turns ulgy things into good looking things.

     response_arr.each do |elephant| # Going over each hash in the JSON.
        month= rand(1..12)
        year= rand(1950..2018)
        date= rand(1..30)
        Elephant.create(
            {
            name: elephant["name"], # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20. 
            affiliation: elephant["affiliation"], # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20.
            species: elephant["species"], # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20.
            gender: elephant["sex"], # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20.
            dob: "#{month}/#{date}/#{year}", # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20.
            worth: rand(13_000..133_200),
            note: elephant["note"] # The things in the [" "] is from what the webpage has. the elephantthat is before the [] is from like 20.
            }
        )
        # binding.pry
     end
end

def insert_listing
    Elephant.all.each do |elephant|
        Listing.create(
            {
                user_id: User.all.first.id, # user_id is from listings table class and were assiging the first user from the User class and the first one. From listings table -> user_id = User.all.first.id <- From User class, getting the first user and theyr ID.
                elephant_id: elephant.id, # elephant_id from listings table class and give the elephant.id from the Elephant table. We know it's from the Elephant table because of line 40. "Elephant.all.each do ..."
                price: elephant.worth, # price from listings table and give it the elephant.worth from Elephant table
                title: elephant.name, # title from listings table and give it the name of the elephant thats saved in the elephants table.
                status: "transaction" # giving the status thats in the listings table table the status of "transcation"
             }
        ) 
    end

    # The method above is asigning all the elemhants to the users and putting their transaction open.

    # The method below is the same but inserd of giving "transaction", here give status "open"
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

insert_elephant() # This is calling the methods. Line 16.
# There are a total of 47 elephant. SHIT BRO!

Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.
Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.
Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.
Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.
Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.
Elephant.all.last.delete # This is deleting the last few elephants that we got from the web because they only have a name and nothing else in their hash.

insert_listing() # This is calling the methods. Line 39.
# we should write this method second. because we need elephants first!


