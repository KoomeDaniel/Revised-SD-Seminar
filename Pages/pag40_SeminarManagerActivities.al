page 50140 "CSD Seminar Manager Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Cue";
    Caption = 'Seminar Manager Activities';
    Editable = false;

    layout
    {
        area(Content)
        {
            cuegroup(Registrations)
            {
                field(Planned; Rec.Planned)
                { }
                field(Registered; Rec.Registered)
                { }
                actions
                {
                    action(New)
                    {
                        Caption = 'New';
                        RunObject = page "CSD Seminar Registration";
                        RunPageMode = Create;
                    }
                }

            }
            cuegroup("For Posting")
            {
                field(Closed; Rec.Closed)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not rec.get then begin
            rec.init;
            rec.insert;
        end;
    end;
}