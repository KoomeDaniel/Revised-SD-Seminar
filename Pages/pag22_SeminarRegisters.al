page 50122 "CSD Seminar Registers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Register";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Creation Date field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Source Code"; Rec."Source Code")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Source Code field.', Comment = '%';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Entry No. field.', Comment = '%';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Entry No. field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group(Register)
            {
                Image = Register;
                action("Seminar Ledger")
                {
                    ApplicationArea = All;
                    Image = WarrantyLedger;
                    RunObject = codeunit "CSD Seminar Reg.-Show Ledger";
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

}