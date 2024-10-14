table 50108 "CSD COMMENT LINE"
{
    Caption = 'COMMENT LINE';
    DataClassification = ToBeClassified;
    LookupPageId = "CSD Seminar comment list";
    DrillDownPageId = "CSD Seminar comment list";
    fields
    {
        field(1; "Document Type."; Option)
        {
            Caption = 'Document No.';
            OptionMembers = "Seminar","Seminar Registration","Posted Seminar Registration";
            DataClassification = ToBeClassified;
        }
        field(2; "No."; code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Document Type." = CONST(Seminar)) "CSD Seminar"
            else if ("Document Type." = const("Seminar Registration")) "CSD Registration Header"
            else if ("Document Type." = const("Posted Seminar Registration")) "CSD Posted Seminar RegHeader";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; Code; code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Document Line No.", "No.", "Line No.", "Document Type.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure SetUpNewLine()//purpose of this procedure is to prepare a new comment line in the CSD COMMENT LINE table by checking if a comment already exists for the specified document type, document number, and document line number. If no comment exists, it sets the Date field to the current date.
    var
        SeminarCommentLine: Record "CSD COMMENT LINE";
    begin
        SeminarCommentLine.Reset();//resets the state of the SeminarCommentLine record variable, clearing any previous filters or values set on it.
        SeminarCommentLine.SetRange("Document Type.", "Document Type.");//Filters the records to those matching the current document type.
        SeminarCommentLine.SetRange("No.", "No.");//Filters to those with the current document number.
        SeminarCommentLine.SetRange("DOCUMENT Line No.", "Document Line No.");//Filters to those with the current document line number.
        SeminarCommentLine.SetRange(Date, WorkDate());//Filters to comment lines that have the current work date.

        if SeminarCommentLine.IsEmpty then//checks if there are any existing records that match the specified criteria. If no matching records are found (i.e., IsEmpty returns true), it proceeds to the next line.
            Date := WorkDate();//If no comment lines exist for the specified criteria, this line sets the Date field of the current record to the current work date (the date on the system).
    end;
}