module Merger
  class Merge
    attr_reader :keep, :duplicates, :options
  
    def initialize(*records)
      @options = records.extract_options!
      records = records.flatten.uniq
      @keep = options[:keep] || records.sort_by(&:id).first
      @duplicates = records - [@keep]
    end
  
    def ignored_associations
      return @ignored if @ignored
      @ignored = Array(options[:skip_association])
      keep.class.reflect_on_all_associations.each do |association|
        @ignored << association.through_reflection.name if association.through_reflection
      end
      @ignored
    end

    def associations!
      keep.class.reflect_on_all_associations.each do |association|
        duplicates.each do |record|
          next if ignored_associations.include?(association.name)
          case association.macro
          when :has_many, :has_and_belongs_to_many
            name = "#{association.name.to_s.singularize}_ids"
            keep.send("#{name}=", keep.send(name) | record.send(name))
          when :belongs_to, :has_one
            keep.send("#{association.name}=", record.send(association.name)) if keep.send("#{association.name}").nil?
          end
        end
      end
    end
    
    def merge!
      keep.class.transaction do
        associations!
        duplicates.each(&:destroy)
      end
    end
  
  end
end