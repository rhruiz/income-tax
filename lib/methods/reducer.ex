defmodule IR.Methods.Reducer do
  @behaviour IR

  def tax(salary, steps, max_rate) do
    tax_reducer = fn
      ({step, rate}, {last_step, acc}) when salary > step ->
        {step, acc + (step - last_step) * rate}

      ({step, _}, {last_step, acc}) when last_step > salary ->
        {step, acc}

      ({step, rate}, {last_step, acc}) ->
        {step, acc + (salary - last_step) * rate}
    end

    compute_max_rate = fn
      ({last_step, acc}) when salary > last_step ->
        acc + (salary - last_step) * max_rate

      ({_, acc}) ->
        acc
    end

    steps
    |> Enum.reduce({0.0, 0.0}, tax_reducer)
    |> compute_max_rate.()
    |> Float.round(2)
  end
end
