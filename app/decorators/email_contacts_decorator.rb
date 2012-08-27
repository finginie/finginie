class EmailContactsDecorator
  attr_reader :contacts

  def initialize(contacts)
    @contacts = contacts
  end

  def data_table_response
    data_table_converted_contacts = contacts.map do |contact|
      ["<input type='checkbox' class='invite' name='contacts[]' value='#{contact.last}' />"] + contact
    end

    { :aaData => data_table_converted_contacts }.to_json
  end
end
