class EnableUuidExtension < ActiveRecord::Migration[8.0]
  def change
    def change
      enable_extension 'pgcrypto' # For PostgreSQL
      # Or for SQLite:
      # enable_extension 'uuid-ossp'
    end
  end
end
