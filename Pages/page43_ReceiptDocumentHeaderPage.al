page 50143 "CSD Seminar Receipt Doc"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Registration Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ToolTip = 'Specifies the value of the Instructor Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                }
                field("Duration (Minutes)"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ToolTip = 'Specifies the value of the Minimum Participants field.', Comment = '%';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.', Comment = '%';
                }
            }
            group("Room Details")
            {

                field("Room Name"; Rec."Room Name")
                {
                    ToolTip = 'Specifies the value of the Room Name field.', Comment = '%';
                }
                field("Room Address"; Rec."Room Address")
                {
                    ToolTip = 'Specifies the value of the Room Address field.', Comment = '%';
                }
                field("Room City"; Rec."Room City")
                {
                    ToolTip = 'Specifies the value of the Room City field.', Comment = '%';
                }
            }
            part(SeminarRegistrationLines; "CSD Registration Subform")
            {
                ApplicationArea = All;
                Caption = 'Participant list';
                SubPageLink = "Document No." = field("No.");
                Editable = false;
            }
        }

    }

    actions
    {
        area(Navigation)
        {
            group("&Seminar Registration")
            {
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = page "CSD Seminar comment sheet";
                    RunPageLink = "No." = field("No.");
                    RunPageView = where("Document Type." = const("Seminar Registration"));
                }
                action("&Charges")
                {
                    ApplicationArea = All;
                    Caption = '&Charges';
                    Image = Cost;
                    RunObject = page "CSD Seminar Charge";
                    RunPageLink = "Document No." = field("No.");
                }
            }
        }

        area(Processing)
        {
            group(Posting)
            {
                Image = Post;
                Caption = 'Posting';

                action("P&ost")
                {
                    Caption = 'P&ost';
                    ApplicationArea = All;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ShortcutKey = F9;
                    RunObject = codeunit "CSD Seminar PostYesNo";
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    var
                        SeminarReportSelection: Record "CSD Seminar Report Selections";
                    begin
                        SeminarReportSelection.PrintReportSelection
                        (SeminarReportSelection.Usage::Registration, Rec);
                    end;
                }

            }
        }
    }


}