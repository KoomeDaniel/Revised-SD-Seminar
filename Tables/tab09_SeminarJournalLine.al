table 50109 "CSD Seminar Journal Line"
{
    Caption = 'Seminar Journal Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Seminar No."; code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;
            TableRelation = "CSD Seminar";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Document Date" := "Posting Date";
            end;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Entry Type"; Option)
        {
            OptionMembers = Registration,Cancellation;
            DataClassification = ToBeClassified;
        }
        field(7; "Document No."; code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Bill-to-Customer"; code[20])
        {
            Caption = 'Bill-to-Customer';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(10; "Charge Type"; Option)
        {
            OptionMembers = Instructor,Room,Participant,charge;
            DataClassification = ToBeClassified;
        }
        field(11; Type; Option)
        {
            OptionMembers = Resource,"G/L Account";
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(13; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(14; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
        }
        field(15; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(16; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            DataClassification = ToBeClassified;
        }
        field(17; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = ToBeClassified;
        }
        field(18; "Room Resource No."; code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Room));
        }
        field(19; "Instructor Resource No."; code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Person));
        }
        field(20; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Seminar Registration No."; code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
        }
        field(22; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "Res. Ledger Entry";
        }
        field(24; "Source Type"; Option)
        {
            OptionMembers = " ",Seminar;
            DataClassification = ToBeClassified;
        }
        field(25; "Source No."; code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Type" = const("Seminar")) "CSD Seminar";
        }
        field(26; "Journal Batch Name"; code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(27; "Source Code"; code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
            Editable = false;
        }
        field(28; "Reason Code"; code[20])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(29; "Posting No. Series"; code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Journal Batch Name", "Line No.", "Journal Template Name")
        {
            Clustered = true;
        }
    }

    procedure EmptyLine(): Boolean
    begin
        exit(("Seminar No." = '') and (Quantity = 0));
    end;
}