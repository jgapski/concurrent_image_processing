%%%-------------------------------------------------------------------
%% @doc cimp top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(cimp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    CimpPublicAPI = {cimp_api,
             {cimp_api, start_link, []},
             permanent, %to change
             5000, %to change
             worker, 
             [cimp_api]},
    CimpEngyneSup = {cimp_engyne_sup,
             {cimp_engyne_sup, start_link, []},
             permanent, %to change
             5000, %to change
             supervisor, 
             [cimp_api]},

 
   {ok, { {one_for_all, 30, 1}, [CimpPublicAPI, CimpEngyneSup]} }.

%%====================================================================
%% Internal functions
%%====================================================================
