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
      (acc, last_step) when salary > last_step ->
        acc + (salary - last_step) * max_rate

      (acc, _) ->
        acc
    end

    compute = Enum.reduce steps, {0.0, 0.0}, tax_reducer

    last_step =
      steps
      |> List.last
      |> elem(0)

    compute
    |> elem(1)
    |> compute_max_rate.(last_step)
    |> Float.round(2)
  end
end
