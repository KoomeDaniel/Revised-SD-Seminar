table 50103 "CSD Participant "
{
    Caption = 'CSD Participant ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Participant ID"; Code[20])
        {
            trigger OnValidate();
            begin
                if "Participant ID" <> xRec."Participant ID" then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Participant Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Participant ID")
        {
            Clustered = true;
        }
    }
    var
        SeMinarSetup: Record "CSD SEMINAR SETUP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CSDParticipant: Record "CSD Participant ";

    trigger OnInsert()
    begin
        if "Participant ID" = '' then begin
            SeMinarSetup.Get;
            SeMinarSetup.TestField("Participant Nos.");
            NoSeriesMgt.InitSeries(SeMinarSetup."Participant Nos.", xRec."No. Series", 0D, "Participant ID", "No. Series");
        end;
    end;

    procedure AssistEdit(): Boolean
    begin
        CSDParticipant := Rec;
        SeminarSetup.get;
        SeminarSetup.TestField("Participant Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Participant Nos.", xRec."No. Series", CSDParticipant."No. Series") then begin
            NoSeriesMgt.SetSeries(CSDParticipant."Participant ID");
            Rec := CSDParticipant;
            exit(true);
        end;
    end;
}
