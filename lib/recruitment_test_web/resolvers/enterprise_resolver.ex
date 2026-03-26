defmodule RecruitmentTestWeb.Resolvers.EnterpriseResolver do
  alias RecruitmentTest.Enterprises.EnterpriseContext

  def get_enterprise(_, %{id: id}, _) do
    with enterprise when not is_nil(enterprise) <- EnterpriseContext.get_enterprise(id, [:owner]) do
      {:ok, enterprise}
    else
      _ -> {:error, "Enterprise not found"}
    end
  end

  def create_enterprise(_, %{input: params}, _) do
    EnterpriseContext.create_enterprise(params)
  end

  def update_enterprise(_, %{id: id, input: params}, _) do
    with enterprise when not is_nil(enterprise) <- EnterpriseContext.get_enterprise(id),
         {:ok, updated_enterprise} <- EnterpriseContext.update_enterprise(enterprise, params) do
      {:ok, updated_enterprise}
    else
      nil -> {:error, "Enterprise not found"}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_enterprise(_, %{id: id}, _) do
    with {:ok, _} <- EnterpriseContext.delete_enterprise(id) do
      {:ok, true}
    else
      {:error, message} -> {:error, message}
    end
  end
end
