require_relative 'entry'

require "csv"


class AddressBook
  attr_reader :entries # creates an entry  for each AddressBook instance
  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
     # #9
     index = 0
     entries.each do |entry|

     #only increase if greater, insert when less than next name lexicographically
      if name >= entry.name
          index+= 1
      else
        break
      end
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

   def import_from_csv(file_name)
     csv_text = File.read(file_name) #reads file ???
     #change to iterable table????? THINK SQL?
     csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
      csv.each do |row|
       row_hash = row.to_hash #create an object with each object's header to its value
       add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
     end

      puts "#{entries.inspect}"
   end

   def binary_search(name)

     #find interval of search - discrminates based on half value
     lower = 0
     upper = entries.length - 1


       # search if lower
      while lower <= upper

         mid = (lower + upper)/2
         mid_name = entries[mid].name

        #  check mid first if
         if name == mid_name
           return entries[mid]
         elsif name > mid_name
           lower = mid + 1
         elsif name < mid_name
           upper = mid - 1
         end
       end

       return nil
     end


end
