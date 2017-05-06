-module(ir).
-export([tax/1, tax/2, start/2]).
-callback tax(float(), list({float(), float()}), float()) -> float().

ranges() ->
  {ok, Steps} = application:get_env(ir, steps),
  Steps.

max_range() ->
  {ok, MaxRate} = application:get_env(ir, max_rate),
  MaxRate.

module(reducer) -> ir_reducer;
module(recursive) -> ir_recursive;
module(Mod) when is_atom(Mod) -> Mod.

tax(Salary) -> tax(Salary, recursive).

tax(Salary, Mod) ->
  apply(module(Mod), tax, [Salary, ranges(), max_range()]).

start(_, _) ->
  io:fwrite("~.2f~n", [tax(12000, reducer)]),
  {ok, spawn_link(fun() -> true end)}.
