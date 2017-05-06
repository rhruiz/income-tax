-module(ir_recursive).
-behaviour(ir).
-export([tax/3]).

recursive(Salary, Steps, MaxRate) ->
  round(recursive(Salary/1.0, 0.0, 0.0, Steps, MaxRate)*100)/100.

recursive(Salary, Acc, PreviousStep, [{Step, Rate}|_], _) when Salary < Step ->
  Acc + (Salary - PreviousStep) * Rate;

recursive(Salary, Acc, PreviousStep, [{Step, Rate}|Tail], MaxRate) ->
  recursive(Salary, Acc + Rate * (Step - PreviousStep), Step, Tail, MaxRate);

recursive(Salary, Acc, PreviousStep, [], MaxRate) ->
  Acc + (Salary - PreviousStep) * MaxRate.

tax(Salary, Steps, MaxRate) ->
  recursive(Salary, Steps, MaxRate).
