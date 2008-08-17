ActiveRecord::Schema.define(:version => 0) do
  create_table :people, :force => true do |t|
    t.string :given_name, :family_name
    t.timestamps
  end
  
  create_table :phones, :force => true do |t|
    t.string :number, :type
    t.belongs_to :person
  end
end
