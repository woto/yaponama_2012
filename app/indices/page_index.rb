ThinkingSphinx::Index.define :page, :with => :active_record do
  indexes title, content
  indexes description
end

