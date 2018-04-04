-module(cimp_image_server).
-include("../include/records.hrl").
-behaviour(gen_server).

%% API
-export([start_link/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

start_link(Path) ->
    gen_server:start_link(?MODULE, [Path], []).

init([Path]) ->
    process_flag(trap_exit, true),
    {ok, Binary} = file:read_file(Path),
    State = #image{path = Path, binary = Binary},
    {ok, State}.

handle_call({brightness_above, E} , _From, State) ->
    Count  = cimp_lib:brightness_above(State#image.binary, E),
    {reply, {bits_of_brightness_above, Count}, State};

handle_call(sum, _From, State) ->
    Sum  = cimp_lib:sum(State#image.binary),
    {reply, {sum, Sum}, State};

handle_call(medium, _From, State) ->
    Medium = cimp_lib:medium_brightness(State#image.binary),
    {reply, {medium, Medium}, State};

handle_call(data, _From, State) ->
    Reply = State#image.binary,
    {reply, Reply, State}.


handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
