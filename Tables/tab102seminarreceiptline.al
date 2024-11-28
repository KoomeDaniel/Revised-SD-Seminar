table 50149 "CSD Seminar Receipt Line"
{
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
        field(4; "Participant Contact No."; Code[30])
        {
            Caption = 'Participant Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            trigger OnValidate()
            begin
                // if ("Bill-to Customer No." = '') or
                // ("Participant Contact No." = '')
                // then
                //     exit;

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
                    "Participant E-mail" := Contact."E-Mail";
                    if CSDSeminarRcpt.Get("Document No.", "Receipt No.") then begin
                        CSDSeminarRcpt."Participant Name" := "Participant Name";
                        CSDSeminarRcpt."Participant E-mail" := "Participant E-mail";
                        CSDSeminarRcpt.Modify();
                    end;
                end;
            end;
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
            trigger OnValidate()
            begin
                Validate("Line Discount %");
                UpdateBalanceAndStatus();
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
                UpdateBalanceAndStatus();
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
                UpdateBalanceAndStatus();
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
                UpdateBalanceAndStatus();
            end;
        }
        field(14; Registered; Boolean)
        {
            caption = 'Registered';
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(15; "Fully Paid"; Boolean)
        {
            caption = 'Fully Paid';
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(16; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'amount paid';
            DecimalPlaces = 2;
            trigger OnValidate()
            begin
                UpdateBalanceAndStatus();
                Rec.Modify();
                UpdateTotalReceiptLines();
                if ("Bill-to Customer No." = '') and ("Participant Contact No." = '') and ("Participant Name" = '') then
                    if CSDSeminarRcpt.get("Document No.", "Receipt No.") then begin
                        "Bill-to Customer No." := CSDSeminarRcpt."Bill-to Customer No.";
                        "Participant Contact No." := CSDSeminarRcpt."Participant Contact No.";
                        "Participant Name" := CSDSeminarRcpt."Participant Name";
                    end;
                exit;
            end;

        }
        field(17; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Caption = 'Balance';
        }
        field(18; "Receipt No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Participant E-mail"; Text[30])
        {
            caption = 'Participant Email';
            DataClassification = ToBeClassified;
        }
        field(20; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Registration fees","Principal fees","Interest fees","Penalty fees","Other fees";
            trigger OnValidate()
            begin
                RecalculateRequiredAmount();
            end;
        }
        field(21; "Required"; Decimal)
        {
            DataClassification = ToBeClassified;
            caption = 'Required';
        }

    }

    keys
    {
        key(PK; "Document No.", "Receipt No.", "Line No.")
        {
            Clustered = true;
        }
        key(key2; "Transaction Type") { }
    }


    var
        GLSetup: Record "General Ledger Setup";
        CSDSeminarRcpt: Record "CSD Seminar Receipt Header";
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactHasDifferentCompanyThanCustomer: Label 'Contact %1 %2 is related to a different company than customer %3.';
        RegistrationRate: Decimal;
        PrincipalRate: Decimal;
        InterestRate: Decimal;
        PenaltyRate: Decimal;
        OtherFeesRate: Decimal;

    trigger OnInsert()
    begin
        if ("Bill-to Customer No." = '') or ("Participant Contact No." = '') then
            GetSeminarRegHeader();
        UpdateBalanceAndStatus();
        RecalculateRequiredAmount();
    end;

    trigger OnModify()
    begin
        UpdateAmount();
        UpdateBalanceAndStatus();
    end;

    trigger OnDelete()
    begin
        TestField(Registered, false);

    end;

    procedure GetSeminarRegHeader();
    begin
        if CSDSeminarRcpt.Get("Document No.", "Receipt No.") then begin
            CSDSeminarRcpt.TestField("Bill-to Customer No.");
            CSDSeminarRcpt.TestField("Participant Contact No.");
            "Seminar Price" := CSDSeminarRcpt."Seminar Price";
            Amount := CSDSeminarRcpt."Seminar Price";
            "Bill-to Customer No." := CSDSeminarRcpt."Bill-to Customer No.";
            "Participant Contact No." := CSDSeminarRcpt."Participant Contact No.";
            "Participant Name" := CSDSeminarRcpt."Participant Name";

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

    procedure UpdateBalanceAndStatus()
    begin
        Balance := Required - "Amount Paid";

        if Balance <= 0 then
            "Fully Paid" := true
        else
            "Fully Paid" := false;
    end;

    local procedure UpdateTotalReceiptLines()
    var
        CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header";
        TotalQty: Decimal;
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        TotalAmountPaid: Decimal;
        FullDocumentNo: Text[50];
    begin
        if Rec."Document No." = '' then
            exit;
        FullDocumentNo := rec."Document No." + '.' + rec."Participant Contact No.";

        TotalQty := 0;
        if Rec.FindSet then
            repeat
                TotalQty += Rec."Amount Paid";
            until Rec.Next = 0;

        TotalAmountPaid := 0;
        SeminarLedgerEntry.Reset();
        SeminarLedgerEntry.SetRange("Document No.", FullDocumentNo);
        if SeminarLedgerEntry.FindSet() then
            repeat
                TotalAmountPaid += SeminarLedgerEntry."Amount Paid";
            until SeminarLedgerEntry.Next() = 0;

        if CSDSeminarRcptHdr.Get(Rec."Document No.", Rec."Receipt No.") then begin
            CSDSeminarRcptHdr."Total Receipt Lines" := TotalQty;
            if TotalAmountPaid > 0 then
                CSDSeminarRcptHdr.Balance := ("Seminar Price" - TotalAmountPaid - TotalQty)
            else
                CSDSeminarRcptHdr.Balance := ("Seminar Price" - TotalQty);
            CSDSeminarRcptHdr.Modify();
        end;
    end;

    procedure RecalculateRequiredAmount()
    var
        CSDSeminarLedgEntry: Record "CSD Seminar Ledger Entry";
        CompositeKey: Text[250];
        LatestBalance: Decimal;
    begin
        // Build the composite key
        CompositeKey := "Document No." + '.' + "Participant Contact No.";

        // Initialize required amount
        "Required" := 0;

        // Filter ledger entries by composite key
        CSDSeminarLedgEntry.SETRANGE("Document No.", CompositeKey);
        CSDSeminarLedgEntry.SETRANGE("Transaction Type", "Transaction Type");

        // Find the latest ledger entry
        if CSDSeminarLedgEntry.FINDLAST then begin
            LatestBalance := CSDSeminarLedgEntry.Balance;

            // Assign the balance to the required field
            "Required" := LatestBalance;
        end else begin
            // If no entry is found, assign a default required amount based on rates
            case "Transaction Type" of
                "Transaction Type"::"Registration fees":
                    "Required" := "Seminar Price" * 0.30;
                "Transaction Type"::"Principal fees":
                    "Required" := "Seminar Price" * 0.40;
                "Transaction Type"::"Interest fees":
                    "Required" := "Seminar Price" * 0.15;
                "Transaction Type"::"Penalty fees":
                    "Required" := "Seminar Price" * 0.10;
                "Transaction Type"::"Other fees":
                    "Required" := "Seminar Price" * 0.05;
            end;
        end;
    end;
}