defmodule RecruitmentTestWeb.Resolvers.OwnerResolver do
  alias RecruitmentTest.Owners.OwnerContext

  def get_owner(_, %{id: id}, _) do
    with owner when not is_nil(owner) <- OwnerContext.get_owner(id) do
      {:ok, owner}
    else
      _ -> {:error, "Owner not found"}
    end
  end

  def create_owner(_, %{input: params}, _) do
    OwnerContext.create_owner(params)
  end

  def update_owner(_, %{id: id, input: params}, _) do
    with owner when not is_nil(owner) <- OwnerContext.get_owner(id),
         {:ok, updated_owner} <- OwnerContext.update_owner(owner, params) do
      {:ok, updated_owner}
    else
      nil -> {:error, "Owner not found"}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_owner(_, %{id: id}, _) do
    with {:ok, _} <- OwnerContext.delete_owner(id) do
      {:ok, true}
    else
      {:error, message} -> {:error, message}
    end
  end
end
