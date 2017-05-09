defmodule IR.ZSpec do
  use ESpec

  alias IR.Methods.{Recursive, Reducer}

  @methods [Recursive, Reducer, :ir_recursive, :ir_reducer]

  @precision 0.02

  example_group do
    for {name, fun} <- %{"elixir" => &IR.tax/2, "erlang" => &:ir.tax/2} do
      for method <- @methods do
        context "using the #{name} dispatcher and #{inspect(method)} module" do
          let :calculator, do: unquote(fun)
          let :method, do: unquote(method)

          it_behaves_like(Ir.Spec)
        end
      end
    end
  end
end
