import ballerina/http;
import ballerina/log;
import ballerina/io;

type VotersDetails record {
    string Votername;
    string phonenumber;
    int VoterNumber;
   
};
Voter v1 ={
    name: "Queen Imbili",
    
    phonenumber: "081276546",
        VoterNumber: "1234",
    
};
Voter v2 ={
    name: "Emma Kenya",
    phonenumber: "0813242457",
    VotersNumber: "4321",
  
};
map <Voter> registeredVoter = {"1234":v1,"4321":v2};

listener http:Listener httpListener = new(9091);


@http:ServiceConfig {
    basePath: "/voters-information"
}
service PassengerManagement on httpListener {
    @http:ResourceConfig {
        path : "/voters-info",
        methods : ["POST"]
    }
    resource function info(http:Caller caller, http:Request request) returns error? {
        
        http:Response res = new;
        
       
        json responseMessage;
        json votersInfoJSON = check request.getJsonPayload();

        log:printInfo("JSON :::" + votersInfoJSON.toString());

        string VoterNumber = voterInfoJSON.voterNumber.toString();
       

        any|error responseOutcome;
        if(registeredVoted.hasKey(stNo)){
            json voter = check json.convert(registeredVoter[VotersNumber]);
            Voter reqVoter = {
            name: voter.Votername.toString(),
            phonenumber: student.phonenumber.toString(),
            VoterNumber:voter.studentNumber.toString()
            };
            json details =   check (json.convert(reqVoter));
            log:printInfo("Voter details:" + details.toString());


            json voterjson = check json.convert(reqVoter);
            responseMessage = {"voter":voterjson};
            io:println("Voter details");
            io:println(voterjson);
            log:printInfo("All details included in the response:" + voterjson.toString());
            res.setJsonPayload(untaint responseMessage);
            responseOutcome = caller->respond(res);

        }else{
            responseMessage = {"message":"Error:No valid voters number provided"};
            res.setJsonPayload(untaint responseMessage);
            io:println(responseMessage);
            responseOutcome = caller->respond(res);
        }

        return;
    }
}
