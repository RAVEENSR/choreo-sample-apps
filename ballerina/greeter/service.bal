// Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com/) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/http;
import ballerina/io;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns json|error {
        http:Client greetingClient = check new ("http://greetings-service-project-api-2712783793:8090", 
        {
            secureSocket: { 
                enable: false
            }
        });

        json|error response = greetingClient->get(string `?name=${name}`);
        if response is error {
            io:println("GET request error:" + response.detail().toString());
        } else {
            io:println("GET request:" + response.toJsonString());
        }
        return response;
    }
}
