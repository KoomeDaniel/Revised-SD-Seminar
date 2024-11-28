table 50104 "csd sms sent"
{
    Caption = 'csd sms sent';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Message ID"; Code[50])
        {
            trigger OnValidate();
            begin
                if "Message ID" <> xRec."Message ID" then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Message Sent Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Phone Number"; Text[20]) { }
        field(3; "Message Text"; Text[250]) { }
        field(4; "Date Time"; DateTime) { }
        field(5; "Status"; Text[50]) { }
        field(6; "Direction"; Enum "Message Direction") { }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Message ID") { Clustered = true; }
    }
    var
        SeMinarSetup: Record "CSD SEMINAR SETUP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        csdsmssent: Record "csd sms sent";

    trigger OnInsert()
    begin
        if "Message ID" = '' then begin
            SeMinarSetup.Get;
            SeMinarSetup.TestField("Message Sent Nos.");
            NoSeriesMgt.InitSeries(SeMinarSetup."Message Sent Nos.", xRec."No. Series", 0D, "Message ID", "No. Series");
        end;
    end;

    procedure AssistEdit(): Boolean
    begin
        csdsmssent := Rec;
        SeminarSetup.get;
        SeminarSetup.TestField("Message Sent Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Message Sent Nos.", xRec."No. Series", csdsmssent."No. Series") then begin
            NoSeriesMgt.SetSeries(csdsmssent."Message ID");
            Rec := csdsmssent;
            exit(true);
        end;
    end;
}

