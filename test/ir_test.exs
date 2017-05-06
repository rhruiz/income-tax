defmodule IRTest do
  use ExUnit.Case

  alias IR.Methods.{Recursive, Reducer}

  @methods [Recursive, Reducer, :ir_recursive, :ir_reducer]

  for {name, fun} <- %{"elixir" => &IR.tax/2, "erlang" => &:ir.tax/2} do
    for method <- @methods do
      test "free range using #{name} dispatcher and #{inspect(method)} module" do
        assert unquote(fun).(1903.98, unquote(method)) == 0.0
        assert unquote(fun).(1500, unquote(method)) == 0.0
        assert unquote(fun).(150, unquote(method)) == 0.0
        assert unquote(fun).(15, unquote(method)) == 0.0
        assert unquote(fun).(1, unquote(method)) == 0.0
        assert unquote(fun).(0, unquote(method)) == 0.0
      end

      describe "using the #{name} dispatcher and #{inspect(method)} module" do
        test "in the 7.5% range should be deducted 142.80" do
          assert unquote(fun).(2000.0, unquote(method)) == Float.round(2000*0.075 - 142.80, 2)
        end

        test "in the 15% range should be deducted 354.80" do
          assert unquote(fun).(3000.0, unquote(method)) == Float.round(3000*0.15 - 354.80, 2)
        end

        test "in the 22.5% range should be deducted 636.13" do
          assert unquote(fun).(4000.0, unquote(method)) == Float.round(4000*0.225 - 636.13, 2)
        end

        test "in the 27.5% range should be deducted 869.36" do
          assert unquote(fun).(5000.0, unquote(method)) == Float.round(5000*0.275 - 869.36, 2)
        end

        test "tax for 1903.99 should be 0" do
          assert unquote(fun).(1903.99, unquote(method)) == 0.0
        end

        test "tax for 2826.65 should be 69.20" do
          assert unquote(fun).(2826.65, unquote(method)) == 69.20
        end

        test "tax for 3751.06 should be 207.86" do
          assert unquote(fun).(3751.06, unquote(method)) == 207.86
        end

        test "tax for 5000.0 should be 505.64" do
          assert unquote(fun).(5000.0, unquote(method)) == 505.64
        end
      end
    end
  end
end
