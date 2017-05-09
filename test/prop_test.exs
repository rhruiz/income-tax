defmodule IrPropertiesTest do
  use ExUnit.Case
  use PropCheck

  alias IR.Methods.{Recursive, Reducer}

  @methods [Recursive, Reducer, :ir_recursive, :ir_reducer]

  @precision 0.02

  for {name, fun} <- %{"elixir" => &IR.tax/2, "erlang" => &:ir.tax/2} do
    for method <- @methods do
      prefix = "using the #{name} dispatcher and #{inspect(method)} module"

      property "#{prefix} in the free range tax should be 0" do
        forall salary <- float(0.0, 1903.98) do
          expected = 0.0
          actual = unquote(fun).(salary, unquote(method))

          abs(expected - actual) < @precision
        end
      end

      property "#{prefix} in the 7.5% range should subtract 142.80" do
        forall salary <- float(1903.98, 2826.65) do
          expected = Float.round(salary * 0.075, 2) - 142.80
          actual = unquote(fun).(salary, unquote(method))

          abs(expected - actual) < @precision
        end
      end

      property "#{prefix} in the 15% range should subtract 354.80" do
        forall salary <- float(2826.65, 3751.05) do
          expected = Float.round(salary * 0.15, 2) - 354.80
          actual = unquote(fun).(salary, unquote(method))

          abs(expected - actual) < @precision
        end
      end

      property "#{prefix} in the 22.5% range should subtract 636.13" do
        forall salary <- float(3751.05, 4664.68) do
          expected = Float.round(salary * 0.225, 2) - 636.13
          actual = unquote(fun).(salary, unquote(method))

          abs(expected - actual) < @precision
        end
      end

      property "#{prefix} in the 15% range should subtract 869.36" do
        forall salary <- float(4664.68, 12000.0) do
          expected = Float.round(salary * 0.275, 2) - 869.36
          actual = unquote(fun).(salary, unquote(method))

          abs(expected - actual) < @precision
        end
      end
    end
  end
end
