page 50121 "CSD Ledger Entries"
{
    Caption = 'Ledger Entries';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Posting Date"; Rec."Posting Date")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Entry Type field.', Comment = '%';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.', Comment = '%';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Type field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Total Price field.', Comment = '%';
                }
                field(Chargeable; Rec.Chargeable)
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Chargeable field.', Comment = '%';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Participant Contact No. field.', Comment = '%';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Partcipant Name field.', Comment = '%';
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Resource No. field.', Comment = '%';
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Room Resource No. field.', Comment = '%';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Registration No. field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    applicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Reason Code field.', Comment = '%';
                }
                field("Res. Ledger Entry No."; Rec."Res. Ledger Entry No.")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Res. Ledger Entry No. field.', Comment = '%';
                }
                field("Source Code"; Rec."Source Code")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Source Code field.', Comment = '%';
                }
                field("Source No."; Rec."Source No.")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Source No. field.', Comment = '%';
                }
                field("Source Type"; Rec."Source Type")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Source Type field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
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
        area(Processing)
        {
            action("&Navigate")
            {
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
    }
    var
        Navigate: Page Navigate;
}