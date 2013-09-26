%%  
%%  Copyright 2013, Andreas Stenius <kaos@astekk.se>
%%  
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%  
%%     http://www.apache.org/licenses/LICENSE-2.0
%%  
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%  

-module(ecapnp_get_tests).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-include("include/ecapnp.hrl").
-import(ecapnp_test_utils, [test_schema/0]).


root_test() ->
    Msg = [<<0,0,0,0, 2,0,3,0>>],
    {ok, Root} = ecapnp_get:root('Test', test_schema(), Msg),
    {ok, T} = ecapnp_schema:lookup('Test', test_schema()),
    Data = (Root#object.ref)#ref.data,
    ?assertEqual(
       #object{ ref=#ref{ segment=0, pos=0, offset=0, data=Data,
                          kind=#struct_ref{ dsize=2, psize=3 } },
                type=T }, Root).

field_test() ->
    Msg = [<<0,0,0,0, 1,0,2,0,
             0:64/integer,
             0:64/integer,
             0:64/integer
           >>],
    {ok, Root} = ecapnp_get:root('Test', test_schema(), Msg),
    ?assertEqual( 12345, ecapnp_get:field(intField, Root)).

-endif.
