class PgDump
  def self.pg_dump
	  ActiveRecord::Base.establish_connection
    table_names = CONFIG.backup['tables']
    table_names.each do |table_name|
      table_path = File.join(Rails.root, 'data', "#{table_name}.csv")
      ActiveRecord::Base.connection.execute("COPY (SELECT * FROM #{table_name} ORDER BY ID) TO '#{table_path}' WITH CSV HEADER")
    end
  end
end
