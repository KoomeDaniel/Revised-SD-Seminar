table 50111 "CSD Seminar Register"
{
    Caption = 'Seminar Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "CSD Seminar Ledger Entry";
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "CSD Seminar Ledger Entry";
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(5; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
        field(7; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Index02; "Creation Date") { }
        key(Index03; "Source Code", "Journal Batch Name", "Creation Date") { }
    }
}