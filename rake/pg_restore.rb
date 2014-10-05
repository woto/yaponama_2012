class PgRestore
  def self.pg_restore
	  ActiveRecord::Base.establish_connection
    table_names = %w(bots brands models generations modifications faqs spare_catalogs spare_infos)
    table_names.each do |table_name|
      table_path = File.join(Rails.root, 'data', "#{table_name}.csv")
      ActiveRecord::Base.connection.execute("TRUNCATE #{table_name}")
      ActiveRecord::Base.connection.execute("COPY #{table_name} FROM '#{table_path}' WITH CSV HEADER")
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
