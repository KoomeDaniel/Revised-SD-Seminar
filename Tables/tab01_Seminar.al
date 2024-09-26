table 50101 "CSD SEMINAR"
{
    DataClassification = ToBeClassified;// is used to categorize the data for privacy and security purposes.
    Caption = 'Seminar';
    LookupPageId = "CSD Seminar List";//This specifies the ID of the lookup page that will be used to display the list of seminars. In this case, it’s the “CSD Seminar List” page .
    DrillDownPageId = "CSD Seminar List";//This specifies the ID of the drill-down page that will be used to display detailed information about a specific seminar. In this case, it’s the “CSD Seminar List” page with ID 50102.

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;// is used to categorize the data for privacy and security purposes.
            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin//checks if the current value of the "No." field is different from its previous value (xRec."No."). xRec represents the record before the change.
                    SeminarSetup.GET;//the record from the SeminarSetup table.
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");//calls the TestManual function from the NoSeriesManagement codeunit, passing the "Seminar Nos." field from the SeminarSetup table. This function checks if manual numbering is allowed for the specified number series.
                    "No. Series" := '';//If the number has changed and manual numbering is allowed, this line clears the "No. Series" field, setting it to an empty string.
                end;
            end;
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(60; "Search Name"; Code[20])
        {
            Caption = 'Search Name';
            DataClassification = ToBeClassified;
        }
        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90; comment; Boolean)
        {
            Caption = 'comment';
            DataClassification = ToBeClassified;
            Editable = false;
            //FieldClass=FlowField;
            //CalcFormula=exist("Seminar Comment Line" 
            //where("Table Name"= const("Seminar"), 
            // "No."=Field("No.")));
        }
        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
        }
        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";// This sets up a relationship with the “Gen. Product Posting Group” table, allowing users to select a value from this related table.
            trigger OnValidate();//This trigger runs when the field value is validated, i.e., when the user changes the value and moves out of the field.
            begin
                if (xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") then begin//checks if the current value of the "Gen. Prod. Posting Group" field is different from its previous value (xRec."Gen. Prod. Posting Group"). xRec represents the record before the change.
                    if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "Gen. Prod. Posting Group") then //calls the ValidateVatProdPostingGroup function from the GenProdPostingGroup table, passing the current GenProdPostingGroup record and the new "Gen. Prod. Posting Group" value. This function checks if the new general product posting group is valid for VAT purposes.
                        Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");//If the validation is successful, this line sets the "VAT Prod. Posting Group" field to the default VAT product posting group defined in the GenProdPostingGroup record.
                end;
            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(130; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Search Name")
        {

        }
    }


    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SeMinarSetup: Record "CSD SEMINAR SETUP";
        Seminar: Record "CSD SEMINAR";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeMinarSetup.Get;
            SeMinarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeMinarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");//This represents the starting date for the number series. In this case, 0D means no specific start date is provided.The xRec refers to the old version of the current record (before any changes). It passes the previous value of the "No. Series" field if it exists.it generates a new seminar number using the specified number series and assigns that number to the No. field of the seminar. The series used to generate the number is also stored in the No. Series field.
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        // CommentLine.Reset;
        // CommentLine.SetRange("Table Name", 
        // CommentLine."Table Name"::Seminar); 
        // CommentLine.SetRange("No.","No.");
        // CommentLine.DeleteAll;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    procedure AssistEdit(): Boolean;//This is a procedure (a block of code) that can be called to provide assistance when editing a seminar record. It returns a boolean value (true or false) to indicate success or failure.
    begin
        Seminar := Rec;//This assigns the current seminar record (Rec) to a variable called Seminar.
        SeminarSetup.get;//This retrieves the seminar setup record (from the table CSD SEMINAR SETUP). 
        SeminarSetup.TestField("Seminar Nos.");//This checks if the Seminar Nos. field in the seminar setup has a valid value (i.e., it’s not empty or missing).
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", Seminar."No. Series") then begin//This is a function from the NoSeriesMgt codeunit (Number Series Management). It allows the user to choose a number series manually for the seminar. 
            NoSeriesMgt.SetSeries(Seminar."No.");//This sets the No. (seminar number) using the selected number series.After the user selects the number series, the system generates and assigns a new number for the seminar.
            Rec := Seminar;//This updates the original seminar record (Rec) with the changes made to the Seminar variable (which now includes the newly assigned number).
            exit(true);// This ends the procedure and returns true, indicating that the process was successful.
        end;
    end;
    //Start: The system begins by copying the current seminar record into a variable called Seminar.
    // Get Setup: It retrieves the seminar setup, which includes details like the seminar number series (the system that generates seminar numbers).
    // Check Setup: The system checks that the number series is properly set up for seminars.
    // Select Series: If everything is correct, the system asks the user to choose a number series for the seminar (if there are multiple options).
    // Generate Number: Based on the user's choice, a new seminar number is generated.
    // Update Record: The new number is assigned to the seminar, and the seminar record is updated with the changes.
    // Success: The procedure finishes successfully, and true is returned, meaning everything went well.

}