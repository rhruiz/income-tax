defmodule IR.Methods.Recursive do
  @behaviour IR

  def tax(salary, steps, max_rate) do
    Float.round(tax(salary/1.0, 0.0, 0.0, Enum.into(steps, []), max_rate), 2)
  end

  defp tax(salary, acc, last_step, [{h, rate}|t], max_rate) when salary > h do
    tax(salary, acc + rate * (h - last_step), h, t, max_rate)
  end

  defp tax(salary, acc, last_step, [{_, rate}|_], _) do
    acc + (salary - last_step) * rate
  end

  defp tax(salary, acc, last_step, [], max_rate) do
    acc + (salary - last_step) * max_rate
  end
end
