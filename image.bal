import ballerina/http;
import ballerina/log;
import ballerina/docker;

//Adding the `@docker:Expose{}` annotation to a listener endpoint exposes the endpoint port.
@docker:Expose {}
listener http:Listener votersDetails = new(9090);

//Adding the `@docker:Config{}` annotation to a service modifies the generated Docker image and Dockerfile.
//This sample generates a Docker image as 
@docker:Config {
    //Docker image name should be voter.
    name: "voter",
    //Docker image version should be v1.0.
    tag: "v1.0"
}
service http:Service /votersDetails on voterDetailsEP {
    resource function get passengerManagement(http:Caller caller) {
        var responseResult = caller->respond("voter information! \n");
        if (responseResult is error) {
            error err = responseResult;
            log:printError("Error sending response", err = err);
        }
    }
}
