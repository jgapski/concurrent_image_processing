-module(cimp_collection_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, load_directory/1, load_img/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).


start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) ->

    {ok, { {one_for_all, 30, 1}, []} }.

%%%===================================================================
%%% Internal functions
%%%===================================================================

load_directory(Path) ->
    Files = filelib:wildcard("*.jpg",Path),
    [load_img(Path ++ "/" ++ F) || F <- Files].

load_img(Path) ->
    Image = {Path,
             {cimp_image_server, start_link, [Path]},
             temporary, %to change
             brutal_kill, %to change
             worker, 
             [cimp_image_server]},
    supervisor:start_child(?MODULE, Image).
