class Feed < Sequel::Model
  unless table_exists?
      set_schema do
        primary_key :id
        text :url
        text :name
      end
      create_table
    end
end
