module RSpecHelpers
  module DB
    def tables_to_be_emptied
      @existing_tables ||= Sequel::Model.db.tables
      tables_to_preserve = %i[schema_info schema_migrations]
      @existing_tables - tables_to_preserve
    end

    def db_truncate_tables
      Sequel::Model.db.run 'SET FOREIGN_KEY_CHECKS = 0'
      tables_to_be_emptied.each do |table|
        Sequel::Model.db[table].truncate
      end
    ensure
      Sequel::Model.db.run 'SET FOREIGN_KEY_CHECKS = 1'
    end

    def db_delete_all_records
      tables_to_be_emptied.each do |table|
        Sequel::Model.db[table].delete
      end
    end
  end
end
