page 50117 "CSD Participant List"
{
    ApplicationArea = All;
    Caption = 'CSD Participant List';
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "CSD Participant ";
    CardPageId = "CSD Participant Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Participant ID"; rec."Participant ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Email"; rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; rec."Phone Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
