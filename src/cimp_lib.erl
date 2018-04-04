-module(cimp_lib).
-include("../include/records.hrl").
-export([sum/1,foldl/3, foldl/2, medium_brightness/1, brightness_above/2]).

foldl(Binary, Fun) ->
    foldl(Binary, 0, Fun).

foldl(<<A:8,Rest/binary>>, Acc, Fun) ->
    foldl(Rest, Fun(A, Acc), Fun);
foldl(<<>>, Acc, _Fun) ->
    Acc.

sum(Binary) ->
    foldl(Binary, fun(Bit,Acc) ->
                           Bit + Acc end).
    
medium_brightness(Binary) ->
    Number = foldl(Binary, fun(_, Acc) -> 
                                   Acc + 1 end),
    round(sum(Binary)/Number).

brightness_above(Binary, E) ->
    foldl(Binary, fun (Bit, Acc) when Bit > E -> 
                          Acc + 1; 
                      (_Bit, Acc) -> Acc end).
                          
    



