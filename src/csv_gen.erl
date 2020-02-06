-module(csv_gen).

-export([newline/1, comma/1, delimiter/1, field/2, row/2]).
-export([newline/2, delimiter/2, field/3, row/3]).

newline(File) ->
  newline(File, []).

newline(File, _Opts) ->
  file:write(File, "\n").

comma(File) ->
  delimiter(File).

delimiter(File) ->
  delimiter(File, []).

delimiter(File, _Opts) ->
  file:write(File, ",").

field(File, Value) ->
  field(File, Value, []).

field(File, Value, _Opts) when is_tuple(Value) ->
  file:write(File, "\""),
  file:write(File, io_lib:format("~p",[Value])),
  file:write(File, "\"");
field(File, Value, _Opts) when is_binary(Value) ->
  Match = binary:match(Value, [<<",">>, <<"\n">>, <<"\"">>]),
  case Match of
    nomatch ->
      file:write(File, Value);
    _ ->
      file:write(File, "\""),
      file:write(File, binary:replace(Value, <<"\"">>, <<"\"\"">>, [global])),
      file:write(File, "\"")
  end;
field(File, Value, Opts) when is_list(Value) ->
  field(File, unicode:characters_to_binary(Value), Opts);
field(File, Value, _Opts) when is_integer(Value) ->
  file:write(File, integer_to_list(Value));
field(File, Value, Opts) when is_atom(Value) ->
  field(File, atom_to_binary(Value, utf8), Opts);
field(File, Value, _Opts) when is_float(Value) ->
  file:write(File, io_lib:format("~f", [Value]));
field(File, Value, _Opts) ->
  file:write(File, io_lib:format("\"~p\"", [Value])).

row(File, Elem) ->
  row(File, Elem, []).

row(File, Elem, Opts) when is_tuple(Elem) ->
  ListElem = tuple_to_list(Elem),
  row(File, ListElem, Opts);
row(File, [], Opts) ->
  newline(File, Opts);
row(File, [Value], Opts) ->
  field(File, Value, Opts),
  newline(File, Opts);
row(File, [Value | Rest], Opts) ->
  field(File, Value, Opts),
  delimiter(File, Opts),
  row(File, Rest, Opts).
