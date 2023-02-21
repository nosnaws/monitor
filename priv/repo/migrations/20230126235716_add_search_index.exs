defmodule Monitor.Repo.Migrations.AddSearchIndex do
  use Ecto.Migration

  def change do
    execute """
      ALTER TABLE notes
        ADD COLUMN searchable_index_col tsvector
        GENERATED ALWAYS AS (
          setweight(to_tsvector('english', coalesce(message, '')), 'A')
        ) STORED;
    """

    execute """
      CREATE INDEX notes_searchable_index ON notes USING GIN (searchable_index_col);
    """
  end
end
