table 50102 "CSD SMS LOGS"
{
    Caption = 'CSD SMS LOGS';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Message ID"; Code[50])
        {
            trigger OnValidate();
            begin
                if "Message ID" <> xRec."Message ID" then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Message Nos.");
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
        CSDSMSLOGS: Record "CSD SMS LOGS";

    trigger OnInsert()
    begin
        if "Message ID" = '' then begin
            SeMinarSetup.Get;
            SeMinarSetup.TestField("Message Nos.");
            NoSeriesMgt.InitSeries(SeMinarSetup."Message Nos.", xRec."No. Series", 0D, "Message ID", "No. Series");
        end;
    end;

    procedure AssistEdit(): Boolean
    begin
        CSDSMSLOGS := Rec;
        SeminarSetup.get;
        SeminarSetup.TestField("Message Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Message Nos.", xRec."No. Series", CSDSMSLOGS."No. Series") then begin
            NoSeriesMgt.SetSeries(CSDSMSLOGS."Message ID");
            Rec := CSDSMSLOGS;
            exit(true);
        end;
    end;
}
