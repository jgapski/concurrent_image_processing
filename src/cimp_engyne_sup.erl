-module(cimp_engyne_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) ->
    {ok, { {one_for_one, 30, 1}, []} }.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%collection(Name) ->
    
