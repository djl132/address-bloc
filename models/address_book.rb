require_relative 'entry'

class AddressBook
  attr_reader :entries
  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
     # #9
     index = 0
     entries.each do |entry|
     # #10
       if name > entry.name
          index+= 1
       end
       break
     end
     # #11
     entries.insert(index, Entry.new(name, phone_number, email))
   end

   def remove_entry(name, phone_number, email)
     index = 0
     entries.each do |entry|
       if(entry.name == name && entry.phone_number == phone_number && entry.email == email)
         entries.delete_at(index)
       end
       index+=1
     end
   end

end
