defmodule RecruitmentTestWeb.Schema.Types.OwnerTypes do
  use Absinthe.Schema.Notation

  object :owner do
    field :id, :id
    field :name, :string
    field :email, :string
    field :cpf, :string
    field :enterprises, list_of(:enterprise)
  end

  input_object :owner_input do
    field :name, :string
    field :email, :string
    field :cpf, :string
  end
end
