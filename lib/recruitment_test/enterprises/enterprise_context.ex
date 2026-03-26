defmodule RecruitmentTest.Enterprises.EnterpriseContext do
  alias RecruitmentTest.Repo
  alias RecruitmentTest.Enterprises.Enterprise

  def create_enterprise(params) do
    %Enterprise{}
    |> Enterprise.changeset(params)
    |> Repo.insert()
  end

  def get_enterprise(id, preload \\ []) do
    case Repo.get(Enterprise, id) do
      nil -> nil
      enterprise -> Repo.preload(enterprise, preload)
    end
  end

  def update_enterprise(%Enterprise{} = enterprise, params) do
    enterprise
    |> Enterprise.changeset(params)
    |> Repo.update()
  end

  def delete_enterprise(id) do
    case Repo.get(Enterprise, id) do
      nil -> {:error, :not_found}
      enterprise -> Repo.delete(enterprise)
    end
  end
end
