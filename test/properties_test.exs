defmodule IrPropertiesTest do
  use ExUnit.Case
  use Quixir

  alias IR.Methods.{Recursive, Reducer}

  @methods [Recursive, Reducer, :ir_recursive, :ir_reducer]

  @precision 0.02

  for {name, fun} <- %{"elixir" => &IR.tax/2, "erlang" => &:ir.tax/2} do
    for method <- @methods do
      describe "using the #{name} dispatcher and #{inspect(method)} module" do
        test "in the free range, tax should be 0" do
          ptest salary: float(min: 0, max: 1903.98) do
            expected = 0.0
            actual = unquote(fun).(salary, unquote(method))

            assert_in_delta expected, actual, @precision
          end
        end

        test "in the 7.5% range should be deducted 142.80" do
          ptest salary: float(min: 1903.98, max: 2826.65) do
            expected = Float.round(salary*0.075, 2) - 142.80
            actual = unquote(fun).(salary, unquote(method))

            assert_in_delta expected, actual, @precision
          end
        end

        test "in the 15% range should be deducted 354.80" do
          ptest salary: float(min: 2826.65, max: 3751.05) do
            expected = Float.round(salary*0.15, 2) - 354.80
            actual = unquote(fun).(salary, unquote(method))

            assert_in_delta expected, actual, @precision
          end
        end

        test "in the 22.5% range should be deducted 636.13" do
          ptest salary: float(min: 3751.05, max: 4664.68) do
            expected = Float.round(salary*0.225, 2) - 636.13
            actual = unquote(fun).(salary, unquote(method))

            assert_in_delta expected, actual, @precision
          end
        end

        test "in the 27.5% range should be deducted 869.36" do
          ptest salary: float(min: 4664.68, max: 12000.0) do
            expected = Float.round(salary*0.275, 2) - 869.36
            actual = unquote(fun).(salary, unquote(method))

            assert_in_delta expected, actual, @precision
          end
        end
      end
    end
  end
end
