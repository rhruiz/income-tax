-module(ir_reducer).
-export([tax/3]).

reducer(Salary, Steps, MaxRate) ->
  TaxReducer = fun({Step, _}, {PreviousStep, Acc}) when PreviousStep > Salary ->
                   {Step, Acc};

                  ({Step, Rate}, {PreviousStep, Acc}) when Salary > Step ->
                   {Step, Acc + (Step - PreviousStep) * Rate};

                  ({Step, Rate}, {PreviousStep, Acc}) ->
                   {Step, Acc + (Salary - PreviousStep) * Rate}
               end,

  ComputeMaxRate = fun({LastStep, Acc}) when Salary > LastStep ->
                       Acc + (Salary - LastStep) * MaxRate;
                      ({_, Acc}) -> Acc
                   end,

  round(ComputeMaxRate(lists:foldl(TaxReducer, {0.0, 0.0}, Steps))*100)/100.

tax(Salary, Steps, MaxRate) -> reducer(Salary, Steps, MaxRate).
