defmodule RecruitmentTest.OwnersTest do
  use RecruitmentTest.DataCase

  alias Ecto.UUID
  alias RecruitmentTest.Owners.{Owner, OwnerContext}

  describe "create owner/1" do
    test "should successfully create an owner" do
      params = %{
        name: "Teste",
        email: "teste@email.com",
        cpf: "12345678900"
      }

      assert {:ok, %Owner{id: owner_id}} = OwnerContext.create_owner(params)
      assert %Owner{} = Repo.get(Owner, owner_id)
    end
  end

  describe "get_owner/2" do
    test "should successfully get an existing owner" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      result = OwnerContext.get_owner(owner.id)

      assert result.id == owner.id
      assert result.name == "Teste"
      assert result.cpf == "12345678900"
    end

    test "should fail when trying to get a inexistent owner" do
      id_fake = UUID.autogenerate()

      assert is_nil(OwnerContext.get_owner(id_fake))
    end
  end

  describe "update_owner/2" do
    test "should successfully update an owner" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      new_params = %{
        name: "Teste 2",
        email: "teste2@email.com",
        cpf: "12345678900"
      }

      assert {:ok, updated} =
               OwnerContext.update_owner(owner, new_params)

      assert updated.name == "Teste 2"
      assert updated.email == "teste2@email.com"
    end
  end

  describe "delete_owner/1" do
    test "should successfully delete a owner" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      assert {:ok, _} =
               OwnerContext.delete_owner(owner.id)

      refute Repo.get(Owner, owner.id)
    end
  end
end
