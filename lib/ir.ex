defmodule IR do
  @callback tax(float(), map(), float()) :: float()

  def tax(salary, method \\ IR.Methods.Recursive) do
    cfg = &Application.get_env(:ir, &1)

    method.tax(salary/1.0, Enum.into(cfg.(:steps), []), cfg.(:max_rate))
  end
end
