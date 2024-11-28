table 50143 "CSD Seminar Receipt Header"
{
    Caption = 'CSD Seminar Receipt ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            trigger OnValidate();
            begin
                if "Receipt No." <> xRec."Receipt No." then begin
                    CSDSEMINARSETUP.GET;
                    NoSeriesMgt.TestManual(CSDSEMINARSETUP."Seminar Receipt Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document No."; code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Seminar No."; code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;

        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Seminar Registration No."; code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
            TableRelation = "CSD Registration Header";
            trigger OnValidate()
            begin
                UpdateFieldsFromSeminarNo();
            end;
        }
        field(8; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Seminar Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Seminar Price';
            DecimalPlaces = 2;
            trigger OnValidate()
            begin
                // UpdateBalance();
            end;
        }
        field(10; "Seminar Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Seminar Name';
        }
        field(11; Status; Option)
        {
            OptionMembers = "Planning","Registration","Closed","Cancelled";
            DataClassification = ToBeClassified;
        }
        field(12; Duration; Decimal)
        {
            Caption = 'Duration (Minutes)';
            DataClassification = ToBeClassified;
        }
        field(13; "Room Name"; Text[50])
        {
            Caption = 'Room Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Room City"; Text[50])
        {
            Caption = 'Room City';
            DataClassification = ToBeClassified;
        }
        field(15; "Instructor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Instructor Name';
        }
        field(16; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
        }
        field(17; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Posting No."; Code[50])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Instructor Resource No."; Text[50])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Reason Code"; Code[50])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
        }
        field(21; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted';
            Editable = false;
            InitValue = false;
        }
        field(22; "Participant Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Participant Name';
        }
        field(23; "Participant E-mail"; Text[40])
        {
            caption = 'Participant Email';
            DataClassification = ToBeClassified;
        }
        field(24; "Total Receipt Lines"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Receipt Lines';
            editable = false;
            trigger OnValidate()
            begin
                // UpdateBalance();
            end;
        }
        field(25; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer where(Blocked = const(" "));

        }
        field(26; "Participant Contact No."; Code[30])
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
            var
                SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
                CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header";
                TotalAmountPaid: Decimal;
                FullDocumentNo: Text[50];
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
                    "Phone Number" := Contact."Phone No.";
                    if "Document No." <> '' then begin
                        FullDocumentNo := "Document No." + '.' + "Participant Contact No.";

                        TotalAmountPaid := 0;
                        SeminarLedgerEntry.Reset();
                        SeminarLedgerEntry.SetRange("Document No.", FullDocumentNo);
                        if SeminarLedgerEntry.FindSet() then begin
                            repeat
                                TotalAmountPaid += SeminarLedgerEntry."Amount Paid";
                            until SeminarLedgerEntry.Next() = 0;
                        end;

                        Balance := ("Seminar Price" - TotalAmountPaid);
                        if Balance <= 0 then
                            Message('The customer has fully paid for the seminar.');

                    end;
                end;
            end;
        }
        field(27; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Balance';

        }
        field(28; "Phone Number"; Text[13])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
        }
        field(29; "Total Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Deposit Amount';

        }



    }

    keys
    {
        key(Key1; "Document No.", "Receipt No.")
        {
            Clustered = true;
        }
    }
    var
        CSDSEMINARSETUP: Record "CSD SEMINAR SETUP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CSDSeminarRcpt: Record "CSD Seminar Receipt Header";
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        ContactHasDifferentCompanyThanCustomer: Label 'Contact %1 %2 is related to a different company than customer %3.';


    trigger OnInsert()
    var
        CSDSeminarLedgEntry: Record "CSD Seminar Ledger Entry";
    begin
        if "Receipt No." = '' then begin
            CSDSEMINARSETUP.Get;
            CSDSEMINARSETUP.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(CSDSEMINARSETUP."Seminar Receipt Nos.", xRec."No. Series", 0D, "Receipt No.", "No. Series");//This represents the starting date for the number series. In this case, 0D means no specific start date is provided.The xRec refers to the old version of the current record (before any changes). It passes the previous value of the "No. Series" field if it exists.it generates a new seminar number using the specified number series and assigns that number to the No. field of the seminar. The series used to generate the number is also stored in the No. Series field.
        end;


    end;

    trigger OnModify()
    begin
        if "Seminar No." <> xRec."Seminar No." then
            UpdateFieldsFromSeminarNo();
        // UpdateBalance();
    end;


    procedure AssistEdit(): Boolean;
    begin
        CSDSeminarRcpt := Rec;
        CSDSEMINARSETUP.get;
        CSDSEMINARSETUP.TestField("Seminar Nos.");
        if NoSeriesMgt.SelectSeries(CSDSEMINARSETUP."Seminar Receipt Nos.", xRec."No. Series", CSDSeminarRcpt."No. Series") then begin
            NoSeriesMgt.SetSeries(CSDSeminarRcpt."Receipt No.");
            Rec := CSDSeminarRcpt;
            exit(true);
        end;
        // UpdateBalance();
    end;

    procedure UpdateFieldsFromSeminarNo()
    var
        CSDRegnHdr: Record "CSD Registration Header";
        CSDSEMINAR: Record "CSD SEMINAR";
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        TotalAmountPaid: Decimal;
        FullDocumentNo: Text[50];
    begin
        if "Seminar Registration No." <> '' then begin
            CSDRegnHdr.Reset();
            CSDRegnHdr.SetRange("No.", "Seminar Registration No.");

            if CSDRegnHdr.FindFirst() then begin
                "Seminar No." := CSDRegnHdr."Seminar No.";
                "Seminar Name" := CSDRegnHdr."Seminar Name";
                "Document No." := CSDRegnHdr."No.";
                "Seminar Registration No." := CSDRegnHdr."No.";
                "Starting Date" := CSDRegnHdr."Starting Date";
                "Instructor Name" := CSDRegnHdr."Instructor Name";
                Status := CSDRegnHdr.Status;
                Duration := CSDRegnHdr.Duration;
                "Room Name" := CSDRegnHdr."Room Name";
                "Room City" := CSDRegnHdr."Room City";
                "Seminar Price" := CSDRegnHdr."Seminar Price";
                "Posting No. Series" := CSDRegnHdr."Posting No. Series";
                "Instructor Resource No." := CSDRegnHdr."Instructor Resource No.";
                "Room Resource No." := CSDRegnHdr."Room Resource No.";
                "Reason Code" := CSDRegnHdr."Reason Code";
                "Posting Date" := CSDRegnHdr."Posting Date";
                "Document Date" := CSDRegnHdr."Document Date";
                // UpdateBalance();
            end;
        end;
    end;

    // local procedure UpdateBalance()
    // begin

    //     Balance := Round(("Seminar Price" - "Total Receipt Lines"), 2);

    // end;
}