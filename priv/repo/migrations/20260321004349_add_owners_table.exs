defmodule RecruitmentTest.Repo.Migrations.AddOwnersTable do
  use Ecto.Migration

  def change do
    create table("owners", primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :cpf, :string

      timestamps()
    end

    create unique_index(:owners, [:cpf])
  end
end
