table 50113 "CSD Posted Seminar RegLine"
{
    Caption = ' Posted Seminar Registration Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = ToBeClassified;

        }
        field(5; "Participant Name"; Text[30])
        {
            caption = 'Participant Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Registration Date"; Date)
        {
            caption = 'Registration Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            caption = 'To Invoice';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
            DataClassification = ToBeClassified;
        }
        field(9; "Confirmation Date"; Date)
        {
            caption = 'Confirmation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            caption = 'Seminar Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
        }
        field(11; "Line Discount %"; Decimal)
        {
            caption = 'Line Discount %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 5;

        }
        field(12; "Line Discount Amount"; Decimal)
        {
            caption = 'Line Discount Amount';
            DataClassification = ToBeClassified;
        }
        field(13; Amount; Decimal)
        {
            caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(14; Registered; Boolean)
        {
            caption = 'Registered';
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(16; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'amount paid';
            DecimalPlaces = 2;
        }
        field(17; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Caption = 'Balance';
        }
        field(18; Description; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
