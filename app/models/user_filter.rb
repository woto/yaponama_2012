class UserFilter
  include ActiveAttr::TypecastedAttributes
  include ActiveAttr::Model

  has_many_reflections = User.reflect_on_all_associations(:has_many) 

  has_many_reflections.each do |refl|
    refl.klass.columns.each do |c|
      self.class_eval <<EOF
        attribute '#{refl.name}___#{c.name}'.to_sym

        #attribute '#{refl.name}_#{c.name}'.to_sym, :type => {
        #  :string => String, 
        #  :datetime => DateTime, 
        #  :integer => Integer, 
        #  :boolean => Boolean, 
        #  :text => String
        #  # TODO
        #  }[c.type]
EOF
      end
  end

end
