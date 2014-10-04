class PgDump
  def self.pg_dump
	  ActiveRecord::Base.establish_connection
    table_names = %w(bots brands models generations modifications faqs spare_catalogs spare_infos)
    table_names.each do |table_name|
      table_path = File.join(Rails.root, 'data', "#{table_name}.csv")
      ActiveRecord::Base.connection.execute("COPY (SELECT * FROM #{table_name}) TO '#{table_path}' WITH CSV HEADER;")
    end
  end
end
