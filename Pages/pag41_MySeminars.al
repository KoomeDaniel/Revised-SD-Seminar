page 50141 "CSD My Seminar"
{
    Caption = 'My Seminars';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD My Seminar";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Seminar No"; Rec."Seminar No")
                { }
                field(Name; Seminar.Name)
                {
                }
                field(Duration; Seminar."Seminar Duration")
                {
                }
                field(Price; Seminar."Seminar Price")
                {
                }
            }
        }
    }
    var
        Seminar: Record "CSD SEMINAR";

    trigger OnOpenPage()
    begin
        rec.SetRange("User ID", UserId);
    end;

    trigger OnAfterGetRecord()
    begin
        if Seminar.Get(Rec."Seminar No") then;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Seminar);
    end;

    local procedure OpenSeminarCard()
    begin
        if Seminar."No." <> '' then
            Page.Run(Page::"CSD Seminar Card", Seminar);
    end;

}