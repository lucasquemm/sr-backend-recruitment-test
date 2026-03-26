defmodule RecruitmentTest.Owners.Owner do
  use RecruitmentTest.Schema

  import Ecto.Changeset

  schema "owners" do
    field :name, :string
    field :email, :string
    field :cpf, :string
    has_many :enterprises, RecruitmentTest.Enterprises.Enterprise
    timestamps()
  end

  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [
      :name,
      :email,
      :cpf
    ])
    |> handle_name()
    |> handle_cpf()
  end

  defp handle_name(changeset) do
    changeset
    |> validate_required(:name)
    |> validate_length(:name, max: 250)
  end

  defp handle_cpf(changeset) do
    changeset
    |> validate_required(:cpf)
    |> update_change(:cpf, &numbers_only/1)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint(:cpf)
  end

  defp numbers_only(value) do
    String.replace(value, ~r/[^\d]/, "")
  end
end
