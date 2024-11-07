page 50105 "CSD receipt list"
{
    ApplicationArea = All;
    Caption = 'csd receipt list';
    PageType = List;
    SourceTable = "CSD Seminar Receipt Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    CardPageId = "CSD Seminar Receipt Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the Participant Name field.', Comment = '%';
                }

            }
        }
    }
}
