page 50104 "CSD Seminar Receipt subform"
{
    ApplicationArea = All;
    Caption = 'SeminarReceiptLine';
    PageType = ListPart;
    DelayedInsert = true;
    AutoSplitKey = true;
    SourceTable = "CSD Seminar Receipt Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                    trigger OnValidate()

                    begin
                        CurrPage.Update();
                    end;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Receipt No. field.', Comment = '%';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;
                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "CSD Ledger Entries";
                    trigger OnDrillDown()
                    var
                        CSDSeminarLedgEntry: Record "CSD Seminar Ledger Entry";
                        CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header";
                        concantenated: code[50];
                    begin
                        if CSDSeminarRcptHdr.Get(Rec."Document No.", Rec."Receipt No.") then begin
                            if CSDSeminarRcptHdr.Posted then begin
                                CSDSeminarLedgEntry.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");
                                concantenated := Rec."Document No." + '.' + Rec."Receipt No.";
                                CSDSeminarLedgEntry.SetRange("Document No.", concantenated);
                                PAGE.Run(PAGE::"CSD Ledger Entries", CSDSeminarLedgEntry);
                            end
                            else begin
                                Message('This receipt is not posted yet.');
                            end;
                        end
                        else begin
                            Message('Receipt Header record not found.');
                        end;
                    end;

                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ToolTip = 'Specifies the value of the amount paid field.', Comment = '%';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                }
                field("Fully Paid"; Rec."Fully Paid")
                {
                    ToolTip = 'Specifies the value of the Fully Paid field.', Comment = '%';
                }
            }
        }
    }
}
