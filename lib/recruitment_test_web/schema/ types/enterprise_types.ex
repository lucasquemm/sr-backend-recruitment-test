defmodule RecruitmentTestWeb.Schema.Types.EnterpriseTypes do
  use Absinthe.Schema.Notation

  object :enterprise do
    field :id, :id
    field :name, :string
    field :commercial_name, :string
    field :cnpj, :string
    field :description, :string
    field :owner, :owner
  end

  input_object :enterprise_input do
    field :name, :string
    field :commercial_name, :string
    field :cnpj, :string
    field :description, :string
    field :owner_id, :id
  end
end
