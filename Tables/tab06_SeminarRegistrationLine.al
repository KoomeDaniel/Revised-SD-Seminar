table 50106 "CSD Seminar Registration Line"
{
    Caption = 'CSD Seminar Registration Line';
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
            TableRelation = Customer where(Blocked = const(" "));
            trigger OnValidate()
            begin
                TestField(Registered, false);
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            trigger OnValidate()
            begin
                if ("Bill-to Customer No." = '') or
                ("Participant Contact No." = '')
                then
                    exit;

                Contact.Get("Participant Contact No.");
                ContactBusinessRelation.Reset;
                ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if not ContactBusinessRelation.FindFirst then
                    exit;
                if ContactBusinessRelation."Contact No." <> Contact."Company Name" then begin
                    Error(ContactHasDifferentCompanyThanCustomer, Contact."No.", Contact."Company Name", "Bill-to Customer No.");
                end;
            end;

            trigger OnLookup()
            begin
                ContactBusinessRelation.Reset;
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if not ContactBusinessRelation.FindFirst then
                    exit;
                Contact.Reset;
                Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                if Page.RunModal(Page::"Contact List", Contact) = ACTION::LookupOK then begin
                    "Participant Contact No." := Contact."No.";
                    "Participant Name" := Contact."Name";
                end;
            end;
        }
        field(5; "Participant Name"; Text[20])
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
            trigger OnValidate()
            begin
                Validate("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            caption = 'Line Discount %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount Amount" := 0
                end else begin
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount;
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            caption = 'Line Discount Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0
                end else begin
                    GLSetup.Get;
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount;
            end;
        }
        field(13; Amount; Decimal)
        {
            caption = 'Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get;
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
            end;
        }
        field(14; Registered; Boolean)
        {
            caption = 'Registered';
            DataClassification = ToBeClassified;
            editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


    var
        GLSetup: Record "General Ledger Setup";
        SeminarRegHeader: Record "CSD Registration Header";
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactHasDifferentCompanyThanCustomer: Label 'Contact %1 %2 is related to a different company than customer %3.';


    trigger OnInsert()
    begin
        GetSeminarRegHeader();
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;

    procedure GetSeminarRegHeader();
    begin
        if SeminarRegHeader."No." <> "Document No." then begin
            SeminarRegHeader.Get("Document No.");
        end;
    end;

    procedure CalculateAmount();
    begin
        Amount := Round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    procedure UpdateAmount();
    begin
        GLSetup.Get;
        Amount := Round("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    end;
}