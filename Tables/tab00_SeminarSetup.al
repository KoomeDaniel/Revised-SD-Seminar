table 50100 "CSD SEMINAR SETUP"
{
    DataClassification = ToBeClassified;
    Caption = 'Seminar Setup';

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(20; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Seminar Registration Nos."; Code[20])
        {
            Caption = 'Seminar Registration Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "Seminar Receipt Nos."; Code[20])
        {
            Caption = 'Seminar Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(60; "Participant Nos."; Code[20])
        {
            Caption = 'Participant Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(70; "Message Nos."; Code[20])
        {
            Caption = 'Message Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(80; "Message Sent Nos."; Code[20])
        {
            Caption = 'Message Sent Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Seminar Registration Nos." = '' then
            "Seminar Registration Nos." := 'SR-0001';
    end;

}