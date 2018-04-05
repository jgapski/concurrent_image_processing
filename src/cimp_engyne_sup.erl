-module(cimp_engyne_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, add_collection/1]).

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

add_collection(Path) ->
        Collection = {Path,
             {cimp_collection_sup, start_link, [Path]},
             permanent, %to change
             5000, %to change
             supervisor, 
             [cimp_collection_sup]},
    supervisor:start_child(?MODULE, Collection).
    
