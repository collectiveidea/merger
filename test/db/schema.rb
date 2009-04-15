ActiveRecord::Schema.define(:version => 0) do
  create_table :people, :force => true do |t|
    t.string :given_name, :family_name
    t.timestamps
  end
  
  create_table :phones, :force => true do |t|
    t.string :number, :type
    t.belongs_to :person
  end

  create_table :tags, :force => true do |t|
    t.string :name
    t.timestamps
  end

  create_table :taggings, :force => true do |t|
    t.belongs_to :person
    t.belongs_to :tag
  end
  
  create_table :companies, :force => true do |t|
    t.belongs_to :person
    t.string :type
    t.string :name
  end
end
