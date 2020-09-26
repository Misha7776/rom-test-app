# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:users) do
      add_column :email, String
      add_column :password_digest, String
    end
  end
end
