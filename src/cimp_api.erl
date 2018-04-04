-module(cimp_api).

-behaviour(gen_server).

%% API
-export([start_link/0, collection/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    {ok, []}.

collection(Name) ->
    gen_server:call(?SERVER,{collection, Name}).

handle_call({collection, Name}, _From, State) ->
    {ok, Pid} = cimp_collection_sup:start_link(),
    Reply = ok,
    {reply, Reply, [{Name, Pid}|State]}.


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
