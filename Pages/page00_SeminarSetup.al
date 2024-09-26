page 50100 "CSD Seminar Setup"
{
    Caption = 'Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD SEMINAR SETUP";

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = All;

                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;

                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.get then begin//Rec.get tries to retrieve the current record. If it fails (meaning the record does not exist), the condition not Rec.get evaluates to true
            Rec.init;//Rec.init sets up the record with default values. It’s like preparing a blank form with default settings.
            Rec.insert;//Rec.insert saves the new record to the database. This ensures that a new record is created if one did not already exist.
        end;
    end;
}