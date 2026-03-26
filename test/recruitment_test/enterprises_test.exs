defmodule RecruitmentTest.EnterprisesTest do
  use RecruitmentTest.DataCase

  alias Ecto.UUID
  alias RecruitmentTest.Enterprises.{Enterprise, EnterpriseContext}
  alias RecruitmentTest.Owners.Owner

  describe "create enterprise/1" do
    test "should fail when trying to create enterprise without owner" do
      params = %{
        name: "Empresa Teste",
        commercial_name: "Empresa Teste Inc",
        cnpj: "12345678901234",
        description: "teste"
      }

      assert {:error, changeset} = EnterpriseContext.create_enterprise(params)

      assert "can't be blank" in errors_on(changeset).owner_id
    end

    test "should successfully create enterprise" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      params = %{
        name: "Empresa Teste",
        commercial_name: "Empresa Teste Inc",
        cnpj: "12345678901234",
        description: "teste",
        owner_id: owner.id
      }

      assert {:ok, %{id: enterprise_id}} = EnterpriseContext.create_enterprise(params)

      assert %Enterprise{} = Repo.get(Enterprise, enterprise_id)
    end
  end

  describe "get_enterprise/2" do
    test "should successfully get a existing enterprise" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      %Enterprise{id: enterprise_id} =
        %Enterprise{}
        |> Enterprise.changeset(%{
          name: "Empresa Teste",
          commercial_name: "Empresa Teste Inc",
          cnpj: "12345678901234",
          description: "teste",
          owner_id: owner.id
        })
        |> Repo.insert!()

      result = EnterpriseContext.get_enterprise(enterprise_id)

      assert result.id == enterprise_id
      assert result.name == "Empresa Teste"
      assert result.owner_id == owner.id
    end

    test "should fail when trying to get a inexistent enterprise" do
      id_fake = UUID.autogenerate()

      assert is_nil(EnterpriseContext.get_enterprise(id_fake))
    end
  end

  describe "update_enterprise/2" do
    test "should successfully update an enterprise" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      enterprise =
        %Enterprise{}
        |> Enterprise.changeset(%{
          name: "Empresa Teste",
          commercial_name: "Empresa Teste Inc",
          cnpj: "12345678901234",
          description: "teste",
          owner_id: owner.id
        })
        |> Repo.insert!()

      new_params = %{
        name: "Empresa Teste 2",
        commercial_name: "Empresa Teste 2 Plus",
        cnpj: "12345678901234",
        description: "teste 2",
        owner_id: owner.id
      }

      assert {:ok, updated} =
               EnterpriseContext.update_enterprise(enterprise, new_params)

      assert updated.name == "Empresa Teste 2"
      assert updated.commercial_name == "Empresa Teste 2 Plus"
      assert updated.description == "teste 2"
    end
  end

  describe "delete_enterprise/1" do
    test "should successfully delete a enterprise" do
      owner =
        %Owner{}
        |> Owner.changeset(%{
          name: "Teste",
          email: "teste@email.com",
          cpf: "12345678900"
        })
        |> Repo.insert!()

      enterprise =
        %Enterprise{}
        |> Enterprise.changeset(%{
          name: "Empresa Teste",
          commercial_name: "Empresa Teste Inc",
          cnpj: "12345678901234",
          description: "teste",
          owner_id: owner.id
        })
        |> Repo.insert!()

      assert {:ok, _} =
               EnterpriseContext.delete_enterprise(enterprise.id)

      refute Repo.get(Enterprise, enterprise.id)
    end
  end
end
