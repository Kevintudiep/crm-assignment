require_relative 'contact'


class CRM

  def initialize


  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
    end
  end

  def add_new_contact
    puts "Enter First Name"
    first_name = gets.chomp

    puts "Enter Last name"
    last_name = gets.chomp

    puts "Enter Email"
    email = gets.chomp

    puts "Enter Notes"
    note = gets.chomp

    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )

  end

  def modify_existing_contact
    puts "Enter a attribute of contact you want to edit"
    attribute = gets.chomp

    puts "Enter the value of attribute"
    value = gets.chomp

    found_contact = Contact.find_by(attribute, value)

    puts "What do you want to update?/n 1. first name, 2. last name 3. email 4. note"
    update_attribute = gets.chomp.to_i

    puts "What value do you want to change?"
    update_value = gets.chomp

    found_contact.update(update_attribute, update_value)

  end

  def delete_contact
    puts "What the ID of the contact you want to delete?"
    id = gets.chomp

    found_contact = Contact.find(id)

    found_contact.delete
  end


  def display_all_contacts
    puts Contact.all.inspect
  end


  def search_by_attribute
    puts "What attribute do you want to search?"
    attribute = gets.chomp

    puts "Enter the value"
    value = gets.chomp

    found_contact = Contact.find_by(attribute, value)
    puts found_contact.inspect
  end

end

my_crm = CRM.new
my_crm.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end
