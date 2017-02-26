require_relative '../models/address_book'

class MenuController

  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu

    # #2
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View an entry"
    puts "6 - Exit"
    puts "7 - destroy addressbook"
    print "Enter your selection: "

    # #3
    selection = gets.to_i

    case selection

      when 1
        system "clear"
        view_all_entries
        main_menu

      when 2
        system "clear"
        create_entry
        main_menu

      when 3
        system "clear"
        search_entries
        main_menu

      when 4
        system "clear"
        read_csv
        main_menu

      when 5
        system "clear"
        view_entry_by_number
        main_menu

      when 6
        puts "Good-bye!"
        exit(0) #exits without error - is that what this does?

      when 7
        puts "destroy all entries"
        destroy
        main_menu

      else
        system "clear"
        puts "Sorry, invalid input."
        main_menu

      end
  end

  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s #display entry info
      entry_submenu(entry) #do something with the entry

    end

    system "clear" #how come it doesnt clear the command line?
    puts "End of entries"
  end

  #add an entry to the address_book
  def create_entry

    system "clear"
    puts "New AddressBloc Entry:"

    print "Name:"
    name = gets.chomp

    print "Phone number:"
    phone = gets.chomp

    print "Email:"
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"

  end

def entry_submenu(entry)

    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

  case selection
    when "n"
    when "d"
      delete_entry(entry)
    when "e"
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
  end
 end

  def view_entry_by_number

    puts "Enter entry number:"
    index = gets.to_i
    system "clear"

    if (index <= address_book.entries.size && index > 0)
      puts address_book.entries[index - 1].to_s
    else
      puts "Invalid entry"
      view_entry_by_number
    end

  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)

    # get input
    print "updated name:"
    name = gets.chomp
    print "number:"
    number = gets.chomp
    print "email:"
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = number if !number.empty?
    entry.email = email if !email.empty?
    system "clear"
    puts "Updated entry"
    puts entry
  end

  def read_csv
    print "Enter CSV file to import:"
    file_name = gets.chomp

#try without filename
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

  # TRY CATCH ERROR OF IMPORTING FILE
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries were added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter a valid file"
      read_csv
    end
  end

  def search_entries
    print "Search by name:"
    name = gets.chomp
    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "did not find match for #{name}"
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
      end
  end

  def destroy
    address_book.entries.each do |entry|
      delete_entry(entry)
    end
  end


end
