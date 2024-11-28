codeunit 50116 "Participant SMS Processor"
{
    Subtype = Normal;

    procedure SendSMS(ParticipantID: Code[20]; Name: Text[100]; PhoneNumber: Text[30]): Boolean
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        RequestBody: Text;
        JsonObject: JsonObject;
        csdsmssent: Record "csd sms sent";
        ResponseText: Text;
    begin
        // Prepare the JSON payload
        JsonObject.Add('Phone_Number', PhoneNumber);
        JsonObject.Add('Message_Text', StrSubstNo('Thank you %1 for registering for the seminar.', Name));
        JsonObject.Add('Date_Time', Format(CurrentDateTime(), 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z'));

        // Convert JSON object to text
        JsonObject.WriteTo(RequestBody);

        // Set up the HTTP content
        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(HttpHeaders); // Get headers from HttpContent
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'application/json');

        // Set up the HTTP request
        HttpRequestMessage.SetRequestUri('https://5a4f-197-237-242-22.ngrok-free.app/sending_sms'); // Replace with your Python service URL
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.Content := HttpContent;

        // Send the HTTP request
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                HttpResponseMessage.Content().ReadAs(ResponseText);
                Message('SMS sent successfully to %1,Phone No.:%2', Name, PhoneNumber);

                // Log the SMS in CSD SMS LOGS
                csdsmssent.Init();
                csdsmssent."Phone Number" := PhoneNumber;
                csdsmssent."Message Text" := 'Thank you ' + Name + ' for registering for the seminar.';
                csdsmssent."Date Time" := CurrentDateTime;
                csdsmssent.Status := 'Sent';
                csdsmssent.Direction := csdsmssent.Direction::Sent;
                csdsmssent.Insert(true);
            end else
                Error('Failed to send SMS. Status code: %1', HttpResponseMessage.HttpStatusCode());
        end else
            Error('Failed to send POST request to webhook.');

        exit(true);
    end;
}
