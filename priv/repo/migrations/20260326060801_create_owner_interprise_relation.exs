defmodule RecruitmentTest.Repo.Migrations.CreateOwnerInterpriseRelation do
  use Ecto.Migration

  def change do
    alter table(:enterprises) do
      add :owner_id, references(:owners, type: :binary_id)
    end
  end
end
