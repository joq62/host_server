%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%%
%%% @end
%%% Created : 24 Sep 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(test_host_server). 

%% API
-export([start/0]).

%%%

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("log.api").
-define(Appl,host_server).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
start()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    ok=test_template(),
    ok=test_basic(),

    ok.


%%--------------------------------------------------------------------
%% @doc
%% test of template 
%% @end
%%--------------------------------------------------------------------
test_basic()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),

    {ok,HostNodes}=host_server:get_host_nodes(), 
    [
     'ctrl@c200','ctrl@c201',
     'ctrl@c202','ctrl@c230','ctrl@c50'
    ]=lists:sort(HostNodes),
    {ok,ApplicationConfigs}=host_server:get_application_config(),
   
    [
     {app1,[{value1,v11},{value2,12}]},
     {app2,[{value1,v21},{value2,22}]},
     {conbee,[{conbee_addr,"172.17.0.2"},{conbee_port,80},{conbee_key,"Glurk"}]}
    ]=lists:sort(ApplicationConfigs),

    ok.


%%--------------------------------------------------------------------
%% @doc
%% test of template 
%% @end
%%--------------------------------------------------------------------
test_template()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),

    pong=?Appl:ping(),
    {Y,M,D}=date(),
    {ok,Y,M,D}=?Appl:template_call(args),
    ok=?Appl:template_cast(args),
    
    ok.


    

%%%===================================================================
%%% Internal functions
%%%===================================================================
