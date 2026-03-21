defmodule RecruitmentTest.Repo.Migrations.CreateOwnerInterpriseRelation do
  alias RecruitmentTest.Enterprises.Enterprise
  use Ecto.Migration

  def change do
      alter table("enterprises") do
        add :owner_id, references("owners")
      end
  end

  def change do
      alter table("owners") do
        add :enterprises, :has_many, Enterprise
      end
  end

end
