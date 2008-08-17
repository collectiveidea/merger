module Merger
  class Merge
    attr_reader :keep, :duplicates
  
    def initialize(*records)
      records = records.flatten
      @keep = records.sort_by(&:id).first
      @duplicates = records - [@keep]
    end
  
    def associations!
      keep.class.reflect_on_all_associations.each do |association|
        duplicates.each do |record|
          case association.macro
          when :has_many, :has_and_belongs_to_many
            name = "#{association.name.to_s.singularize}_ids"
            keep.send("#{name}=", keep.send(name) | record.send(name))
          when :belongs_to, :has_one
            keep.send("#{association.name}=", record.send(association.name))
          end
        end
      end
    end
    
    def merge!
      associations!
      duplicates.each(&:destroy)
    end
  
  end
end