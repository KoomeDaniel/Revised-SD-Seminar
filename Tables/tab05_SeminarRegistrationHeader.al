table 50105 "CSD Registration Header"
{
    Caption = 'Registration Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "No." = '' then begin
                    SeminarSetup.GET;
                    SeminarSetup.TESTFIELD("Seminar Registration Nos.");
                    NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                end
            end;
        }

        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;
            TableRelation = "CSD SEMINAR" where(Blocked = const(false));
            trigger OnValidate()
            begin
                IF "Seminar No." = xRec."Seminar No." THEN
                    exit;

                Seminar.GET("Seminar No.");
                Seminar.TESTFIELD(Blocked, FALSE);
                Seminar.TESTFIELD("Gen. Prod. Posting Group");
                Seminar.TESTFIELD("VAT Prod. Posting Group");
                "Seminar Name" := Seminar.Name;
                Duration := Seminar."Seminar Duration";
                "Seminar Price" := Seminar."Seminar Price";
                "Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                "VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                "Minimum Participants" := Seminar."Minimum Participants";
                "Maximum Participants" := Seminar."Maximum Participants";
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Instructor Resource No."; Text[50])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Person));
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            DataClassification = ToBeClassified;
        }
        field(7; Status; Option)
        {
            OptionMembers = "Planning","Registration","Closed","Cancelled";
            DataClassification = ToBeClassified;
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(11; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Room));
            trigger OnValidate()
            var
                SeminarRoom: Record Resource;
            begin
                if "Room Resource No." = xRec."Room Resource No." then
                    exit;

                IF "Room Resource No." = '' THEN BEGIN
                    "Room Name" := '';
                    "Room Address" := '';
                    "Room Address 2" := '';
                    "Room Post Code" := '';
                    "Room City" := '';
                    "Room County" := '';
                    "Room Country/Region Code" := '';
                END ELSE BEGIN
                    SeminarRoom.GET("Room Resource No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                    "Room Address 2" := SeminarRoom."Address 2";
                    "Room Post Code" := SeminarRoom."Post Code";
                    "Room City" := SeminarRoom.City;
                    "Room County" := SeminarRoom.County;
                    "Room Country/Region Code" := SeminarRoom."Country/Region Code";

                    IF CurrFieldNo = 0 THEN
                        exit;

                    IF (SeminarRoom."CSD Maximum Participants" <> 0) AND
                       (SeminarRoom."CSD Maximum Participants" < "Maximum Participants")
                    THEN BEGIN
                        IF CONFIRM(ChangeSeminarRoomQst, TRUE,
                             "Maximum Participants",
                             SeminarRoom."CSD Maximum Participants",
                             FIELDCAPTION("Maximum Participants"),
                             "Maximum Participants",
                             SeminarRoom."CSD Maximum Participants")
                        THEN
                            "Maximum Participants" := SeminarRoom."CSD Maximum Participants";
                    END;
                END;
            end;
        }
        field(12; "Room Name"; Text[50])
        {
            Caption = 'Room Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Room Address"; Text[50])
        {
            Caption = 'Room Address';
            DataClassification = ToBeClassified;
        }
        field(14; "Room Address 2"; Text[50])
        {
            Caption = 'Room Address 2';
            DataClassification = ToBeClassified;
        }
        field(15; "Room Post Code"; Code[50])
        {
            Caption = 'Room Post Code';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Room City",
                    "Room Post Code",
                    "Room County",
                    "Room Country/Region Code",
                    (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(16; "Room City"; Text[50])
        {
            Caption = 'Room City';
            DataClassification = ToBeClassified;
        }
        field(17; "Room Country/Region Code"; Code[50])
        {
            Caption = 'Room Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(18; "Room County"; Text[50])
        {
            Caption = 'Room County';
            DataClassification = ToBeClassified;
        }
        field(19; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;
        }
        field(20; "Gen. Prod. Posting Group"; Code[50])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(21; "VAT Prod. Posting Group"; Code[50])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(25; "Reason Code"; Code[50])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(26; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(27; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                if "Posting No. Series" = '' then
                    exit;
                TestField("Posting No.", '');

                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
            end;

            trigger OnLookup()
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series") then
                    Validate("Posting No. Series");

                Rec := SeminarRegHeader;
            end;
        }
        field(28; "Posting No."; Code[50])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(IDEX2; "Room Resource No.")
        {
            SumIndexFields = Duration;
        }
    }

    var
        SeminarSetup: Record "CSD SEMINAR SETUP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        Seminar: Record "CSD SEMINAR";
        SeminarRegHeader: Record "CSD REGISTRATION HEADER";
        SeminarCommentLine: Record "CSD COMMENT LINE";
        ErrCannotDeleteLine: Label 'Cannot delete the Seminar Registration, there exists at least one %1 where %2=%3.';
        ErrCannotDeleteCharge: Label 'Cannot delete the Seminar Registration, there exists at least one %1.';
        ChangeSeminarRoomQst: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        InitRecord;

        if GetFilter("Seminar No.") = '' then
            exit;

        IF GetRangeMin("Seminar No.") = GetRangeMax("Seminar No.") THEN
            Validate("Seminar No.", GetRangeMin("Seminar No."));
    end;

    trigger OnDelete()
    begin
        if (CurrFieldNo > 0) then
            TestField(Status, Status::Cancelled);

        //     SeminarRegLine.RESET;
        //     SeminarRegLine.SETRANGE("Document No.", "No.");
        //     SeminarRegLine.SETRANGE(Registered, TRUE);
        //     IF SeminarRegLine.FIND('-') THEN
        //         ERROR(
        //           ErrCannotDeleteLine,
        //           SeminarRegLine.TABLECAPTION,
        //           SeminarRegLine.FIELDCAPTION(Registered),
        //           TRUE);
        //     SeminarRegLine.SETRANGE(Registered);
        //     SeminarRegLine.DELETEALL(TRUE);

        //     SeminarCharge.RESET;
        //     SeminarCharge.SETRANGE("Document No.", "No.");
        //     IF NOT SeminarCharge.ISEMPTY THEN
        //         ERROR(ErrCannotDeleteCharge, SeminarCharge.TABLECAPTION);

        //     SeminarCommentLine.Reset();
        //     SeminarCommentLine.SetRange(
        //         "Document Type", SeminarCommentLine."Document Type"::"Seminar Registration");
        //     SeminarCommentLine.SetRange("No.", "No.");
        //     SeminarCommentLine.DeleteAll();
    end;

    procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();

        "Document Date" := WorkDate();

        SeminarSetup.Get();
        SeminarSetup.TestField("Posted Seminar Reg. Nos.");
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos.");
    end;

    procedure AssistEdit(OldSeminarRegHeader: Record "CSD Registration Header"): Boolean
    begin
        SeminarRegHeader := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        if not NoSeriesMgt.SelectSeries(
            SeminarSetup."Seminar Registration Nos.",
            OldSeminarRegHeader."No. Series", "No. Series") then
            exit(false);

        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        NoSeriesMgt.SetSeries("No.");
        Rec := SeminarRegHeader;
        exit(TRUE);
    end;
}