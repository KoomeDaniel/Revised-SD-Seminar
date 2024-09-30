page 50111 "CSD Seminar Registration List"
{
    ApplicationArea = All;
    Caption = 'Seminar Registration List';
    PageType = List;
    SourceTable = "CSD Registration Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "CSD Seminar Registration";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                }
            }
            part(SeminarDetails; "CSD Seminar Details Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
            }
            systempart(RecordLinks; Links)
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
                    RunObject = codeunit "Seminar Post YESNO";
                }
            }
        }
    }
}
