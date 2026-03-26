defmodule RecruitmentTestWeb.Schema do
  use Absinthe.Schema

  alias RecruitmentTestWeb.Resolvers.EnterpriseResolver
  alias RecruitmentTestWeb.Resolvers.OwnerResolver

  import_types RecruitmentTestWeb.Schema.Types.EnterpriseTypes
  import_types RecruitmentTestWeb.Schema.Types.OwnerTypes

  query do
    @desc "Return an enterprise"
    field :enterprise, :enterprise do
      arg(:id, non_null(:id))
      resolve &EnterpriseResolver.get_enterprise/3
    end

    @desc "Return an owner"
    field :owner, :owner do
      arg(:id, non_null(:id))
      resolve &OwnerResolver.get_owner/3
    end
  end

  mutation do
    @desc "Create an enterprise"

    field :create_enterprise, :enterprise do
      arg(:input, non_null(:enterprise_input))
      resolve &EnterpriseResolver.create_enterprise/3
    end

    @desc "Update an enterprise"
    field :update_enterprise, :enterprise do
      arg(:id, non_null(:id))
      arg(:input, non_null(:enterprise_input))
      resolve &EnterpriseResolver.update_enterprise/3
    end

    @desc "Delete an enterprise"
    field :delete_enterprise, :boolean do
      arg(:id, non_null(:id))
      resolve &EnterpriseResolver.delete_enterprise/3
    end

    @desc "Create an owner"

    field :create_owner, :owner do
      arg(:input, non_null(:owner_input))
      resolve &OwnerResolver.create_owner/3
    end

    @desc "Update an owner"
    field :update_owner, :owner do
      arg(:id, non_null(:id))
      arg(:input, non_null(:owner_input))
      resolve &OwnerResolver.update_owner/3
    end

    @desc "Delete an owner"
    field :delete_owner, :boolean do
      arg(:id, non_null(:id))
      resolve &OwnerResolver.delete_owner/3
    end
  end
end
