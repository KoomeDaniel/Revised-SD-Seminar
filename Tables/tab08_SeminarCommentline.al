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
            TableRelation = if ("Document Type." = const("Seminar")) "CSD SEMINAR";
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

    fieldgroups
    {
        // Add changes to field groups here
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

    procedure SetUpNewLine()
    var
        SeminarCommentLine: Record "CSD COMMENT LINE";
    begin
        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Document Type.", "Document Type.");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.SetRange("DOCUMENT Line No.", "Document Line No.");
        SeminarCommentLine.SetRange(Date, WorkDate());

        if SeminarCommentLine.IsEmpty then
            Date := WorkDate();
    end;
}