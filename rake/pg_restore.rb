class PgRestore
  def self.pg_restore
	  ActiveRecord::Base.establish_connection
    table_names = %w(bots brands models generations modifications faqs spare_catalogs spare_infos)
    table_names.each do |table_name|
      table_path = File.join(Rails.root, 'data', "#{table_name}.csv")
      ActiveRecord::Base.connection.execute("COPY #{table_name} FROM '#{table_name}.csv' WITH CSV HEADER")
    end
  end
end
