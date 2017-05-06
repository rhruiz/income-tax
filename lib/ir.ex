defmodule IR do
  @callback tax(float(), [{float(), float()}], float()) :: float()

  def tax(salary, method \\ IR.Methods.Recursive) do
    cfg = &Application.get_env(:ir, &1)

    method.tax(salary/1.0, cfg.(:steps), cfg.(:max_rate))
  end
end
