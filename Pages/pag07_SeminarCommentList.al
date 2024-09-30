page 50107 "CSD Seminar comment list"
{
    Caption = 'Seminar comment list';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD COMMENT LINE";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Date; Rec.Date)
                {
                }
                field(Code; Rec.Code)
                {
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }

    }
}