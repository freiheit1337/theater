Sequel.migration do
  transaction
  change do
    create_table :events do
      primary_key :id

      Integer :start_time
      Integer :end_time
      String :title
    end
  end
end
