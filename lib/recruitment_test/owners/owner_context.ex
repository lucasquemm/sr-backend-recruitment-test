defmodule RecruitmentTest.Owners.OwnerContext do
  alias RecruitmentTest.Repo
  alias RecruitmentTest.Owners.Owner

  def create_owner(params) do
    %Owner{}
    |> Owner.changeset(params)
    |> Repo.insert()
  end

  def get_owner(id, preload \\ []) do
    case Repo.get(Owner, id) do
      nil -> nil
      owner -> Repo.preload(owner, preload)
    end
  end

  def update_owner(%Owner{} = owner, params) do
    owner
    |> Owner.changeset(params)
    |> Repo.update()
  end

  def delete_owner(id) do
    case Repo.get(Owner, id) do
      nil -> {:error, "Owner not found"}
      owner -> Repo.delete(owner)
    end
  end
end
