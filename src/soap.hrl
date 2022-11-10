%%
%% %CopyrightBegin%
%%
%% Copyright Hillside Technology Ltd. 2016. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

-define(SOAP_NS, "http://schemas.xmlsoap.org/soap/envelope/").
-define(SOAP12_NS, "http://www.w3.org/2003/05/soap-envelope").

-record(op, {
    name :: string(),
    operation :: atom(), %% name of function as used in handler module
    soap_action = [] :: string(),
    wrapper_ns = [] :: string() | undefined, %% namespace for the wrapper element (in
                                 %% case of rpc style)
    op_type :: notification | request_response | undefined,
    in_type :: [{string(), atom()}]  | atom(), %% the list type is only used
                                               %% during construction of the
                                               %% interface
    out_type :: [{string(), atom()}] | undefined | atom(), %% see above
    fault_types :: [atom()] | undefined}).
-type op() :: #op{}.

-record(interface, {
    service :: string(),
    module :: module() | undefined, %% The module that makes the interface available
    version :: '1.1' | '1.2' | undefined,
    http_client :: module() | undefined,
    http_server :: module() | undefined,
    server_handler :: module() | undefined,
    client_handler :: module() | undefined,
    http_options = [] :: [any()] | undefined,
    target_ns :: string() | undefined,
    soap_ns :: string() | undefined,
    style :: string() | undefined, %% "rpc" | "document"
    decoders :: [{string(), module}] | undefined,
    url :: string() | undefined,
    port :: string(),
    binding :: string() | undefined,
    port_type :: string() | undefined,
    ops = [] :: [op()] | undefined,
    model :: erlsom:model() | undefined,
    %% the fields below are only used during the creation of the interface
    prefix_count = 0 :: integer() | undefined, %% used to assign unique prefixes
    tns_prefix :: string() | undefined, %% used for rpc type wsdl if the target ns
                                        %% is also used as the ns of an operation.
    imported = [] :: [{string(), string() | undefined}] %% imported namespaces,
    %% {URI, Prefix}, to prevent duplicates and to be able to add the
    %% prefix later on.
}).
-type interface() :: #interface{}.
