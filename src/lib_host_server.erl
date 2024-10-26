%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%%
%%% @end
%%% Created : 26 Oct 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(lib_host_server).

-include("host_server.hrl").

%% API
-export([
	 get_host_nodes/1,
	 get_application_config/1
	]).

%%%===================================================================
%%% API
%%%===================================================================


get_host_nodes(SpecsDir)->
    {ok,Files}=file:list_dir(SpecsDir),
    HostFiles=[filename:join(SpecsDir,File)||File<-Files,
					     ?SpecExt=:=filename:extension(File)],
    Maps=[get_map_from_file(File)||File<-HostFiles],
    HostNodes=[maps:get(host_node,Map)||Map<-Maps],
    {ok,HostNodes}.


%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
get_application_config(SpecsDir)->
    {ok,Files}=file:list_dir(SpecsDir),
    HostFiles=[filename:join(SpecsDir,File)||File<-Files,
					     ?SpecExt=:=filename:extension(File)],
    Maps=[get_map_from_file(File)||File<-HostFiles],
    {ok,Host}=net:gethostname(),
    ApplicationConfigs=lists:append([maps:get(application_config,Map)||Map<-Maps,
					 Host=:=maps:get(hostname,Map)]),
    {ok,ApplicationConfigs}.
    


%%%===================================================================
%%% Internal functions
%%%===================================================================
%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
get_map_from_file(File)->
    {ok,[Map]}=file:consult(File),
    Map.
