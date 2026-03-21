defmodule RecruitmentTest.Repo.Migrations.AddOwnersTable do
  use Ecto.Migration

  def change do
      create table("owners") do
        add :name, :string, null: false
        add :email, :string, null: false
        add :cpf, :string, null: false


        timestamps()
      end
  end
end
