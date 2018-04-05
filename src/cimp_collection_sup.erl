-module(cimp_collection_sup).

-behaviour(supervisor).

%% API
-export([start_link/1, load_directory/1, load_img/1, answer/1]).

%% Supervisor callbacks
-export([init/1]).


start_link(Path) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [Path]).


init([Path]) ->
    Images = load_directory(Path),
    {ok, { {one_for_one, 30, 1}, Images} }.

%%%===================================================================
%%% Internal functions
%%%===================================================================

load_directory(Path) ->
    Files = filelib:wildcard("*.jpg",Path),
    [load_img(Path ++ "/" ++ F) || F <- Files].

load_img(Path) ->
    {Path,
     {cimp_image_server, start_link, [Path]},
     temporary, %to change
     brutal_kill, %to change
     worker, 
     [cimp_image_server]}.
    %supervisor:start_child(?MODULE, Image).

pids() ->
    [Pid || {_,Pid,_,_} <- supervisor:which_children(?MODULE)].

answer(Request) ->
    [gen_server:call(Pid, Request) || Pid <- pids()].
    
