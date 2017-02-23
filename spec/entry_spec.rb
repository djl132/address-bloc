require_relative '../models/entry'

  RSpec.describe Entry do

    describe "attributes" do
      # is this supposed to create an entry method that returns a symbol? --> method
    let(:entry)  {Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')}
      it "responds to name" do
        expect(entry).to respond_to(:name)
      end
      it "responds to phone number" do
        expect(entry).to respond_to(:phone_number)
      end
      it "responds to email" do
        expect(entry).to respond_to(:email)
      end
    end
#  The in front of to_s indicates that it is an instance method.
    describe "#to_s" do
      it "prints an entry as a string" do
        entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
        expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
        expect(entry.to_s).to eq(expected_string)
      end
    end


  end
