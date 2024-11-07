page 50103 "CSD Seminar Receipt Header"
{
    ApplicationArea = All;
    Caption = 'CSD Seminar Receipt Header';
    PageType = Document;
    SourceTable = "CSD Seminar Receipt Header";
    UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';


                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Importance = Promoted;//This property specifies the importance of the field. In this case, it’s set to Promoted, which means the field will be displayed more prominently in the user interface.
                    AssistEdit = true;//This makes the field editable with assistance, meaning users can interact with the field to manually select or change its value
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();//This trigger runs when the user clicks the assist-edit button next to the field. The procedure checks if the record allows for assist-editing (Rec.AssistEdit) and updates the current page if successful (CurrPage.Update()).
                    end;
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    ToolTip = 'Specifies the value of the Seminar Registration No. field.', Comment = '%';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                    Editable = false;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                    Editable = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                    Editable = false;
                }
                field("Duration (Minutes)"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.', Comment = '%';
                    Editable = false;
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ToolTip = 'Specifies the value of the Instructor Name field.', Comment = '%';
                    Editable = false;
                }
                field("Room Name"; Rec."Room Name")
                {
                    ToolTip = 'Specifies the value of the Room Name field.', Comment = '%';
                    Editable = false;
                }
                field("Room City"; Rec."Room City")
                {
                    ToolTip = 'Specifies the value of the Room City field.', Comment = '%';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
            }
            part("Receipt Line"; "CSD Seminar Receipt subform")
            {
                ApplicationArea = All;
                Caption = 'Receipt Line';
                SubPageLink = "Document No." = field("Document No."), "Receipt No." = field("Receipt No.");
            }
        }
    }
    actions
    {
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
                    PromotedCategory = Process;
                    Visible = not Rec.Posted;
                    trigger OnAction()
                    var
                        RegLineNo: Integer;
                        RegmaxLineNo: Integer;
                    begin
                        CLEARALL;
                        CSDSeminarRcptHdr := Rec;
                        CSDSeminarRcptHdr.TESTFIELD("Posting Date");
                        CSDSeminarRcptHdr.TESTFIELD("Document Date");
                        CSDSeminarRcptHdr.TESTFIELD("Seminar No.");
                        CSDSeminarRcptHdr.TESTFIELD(Duration);
                        CSDSeminarRcptHdr.TESTFIELD("Instructor Resource No.");
                        CSDSeminarRcptHdr.TESTFIELD("Room Resource No.");
                        // CSDSeminarRcptHdr.TESTFIELD(Status, CSDSeminarRcptHdr.Status::Closed);

                        CSDSeminarRcptLn.RESET;
                        CSDSeminarRcptLn.SETRANGE("Document No.", Rec."Document No.");
                        IF CSDSeminarRcptLn.ISEMPTY THEN
                            ERROR(NoParticipantErr);

                        Window.OPEN(
                        '#1#################################\\' +
                        PostingLineNoTxt);
                        Window.UPDATE(1, STRSUBSTNO('%1 %2', Text003, Rec."Document No."));

                        IF CSDSeminarRcptHdr."Posting No." = '' THEN BEGIN
                            Rec.TESTFIELD("Posting No. Series");
                            Rec."Posting No." := NoSeriesMgt.GetNextNo(Rec."Posting No. Series", Rec."Posting Date", TRUE);
                            Rec.MODIFY;
                            COMMIT;
                        END;
                        CSDSeminarRcptLn.LOCKTABLE;

                        SourceCodeSetup.GET;
                        SourceCode := SourceCodeSetup."CSD Seminar";
                        LineCount := 0;
                        CSDSeminarRcptLn.RESET;
                        CSDSeminarRcptLn.SETRANGE("Document No.", Rec."Document No.");
                        CSDSeminarRcptLn.SetRange("Receipt No.", rec."Receipt No.");
                        IF CSDSeminarRcptLn.FINDSET THEN BEGIN
                            REPEAT
                                LineCount := LineCount + 1;
                                Window.UPDATE(2, LineCount);

                                CSDSeminarRcptLn.TESTFIELD("Bill-to Customer No.");
                                CSDSeminarRcptLn.TESTFIELD("Participant Contact No.");

                                IF NOT CSDSeminarRcptLn."To Invoice" THEN BEGIN
                                    CSDSeminarRcptLn."Seminar Price" := 0;
                                    CSDSeminarRcptLn."Line Discount %" := 0;
                                    CSDSeminarRcptLn."Line Discount Amount" := 0;
                                    CSDSeminarRcptLn.Amount := 0;
                                END;

                                // Post seminar entry
                                PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Participant);
                                PostReceipt(Rec);

                                CSDSeminarRegnLn.Reset();
                                CSDSeminarRegnLn.SetRange("Document No.", Rec."Document No.");
                                if CSDSeminarRegnLn.FindLast() then
                                    RegMaxLineNo := CSDSeminarRegnLn."Line No."
                                else
                                    RegMaxLineNo := 0;

                                RegLineNo := RegMaxLineNo + 1;


                                CSDSeminarRegnLn.Init();
                                CSDSeminarRegnLn.TransferFields(CSDSeminarRcptLn);
                                CSDSeminarRegnLn."Document No." := Rec."Document No.";
                                CSDSeminarRegnLn."Line No." := RegLineNo;
                                CSDSeminarRegnLn.Insert();
                            UNTIL CSDSeminarRcptLn.NEXT = 0;

                            Rec.Posted := TRUE;
                            rec.Modify();
                            Commit();


                            if CSDRegnHdr.Get(Rec."Document No.") then begin
                                CSDRegnHdr.Status := CSDRegnHdr.Status::Registration;
                                CSDRegnHdr.Modify();
                            end;

                            Rec := CSDSeminarRcptHdr;
                            CurrPage.update();

                        end;
                    end;
                }
            }
        }
    }
    var
        SeminarJnlLine: Record "CSD Seminar Journal Line";
        CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header";
        CSDSeminarRcptLn: Record "CSD Seminar Receipt Line";
        PstdSeminarRegLine: Record "CSD Posted Seminar RegLine";
        LineCount: Integer;
        Window: Dialog;
        SourceCode: Code[10];
        SeminarJnlPostLine: Codeunit "CSD Seminar Jnl.-Post Line";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoParticipantErr: Label 'There is no participant to post.';
        PostingLineNoTxt: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        CSDSeminarRegnLn: Record "CSD Seminar Registration Line";
        CSDRegnHdr: Record "CSD Registration Header";

    LOCAL PROCEDURE PostSeminarJnlLine(ChargeType: Option Instructor,Room,Participant,Charge)
    BEGIN
        SeminarJnlLine.INIT;
        SeminarJnlLine."Seminar No." := CSDSeminarRcptHdr."Seminar No.";
        SeminarJnlLine."Posting Date" := CSDSeminarRcptHdr."Posting Date";
        SeminarJnlLine."Document Date" := CSDSeminarRcptHdr."Document Date";
        SeminarJnlLine."Document No." := CSDSeminarRcptHdr."Seminar Registration No." + '.' + CSDSeminarRcptHdr."Receipt No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Resource No." := CSDSeminarRcptHdr."Instructor Resource No.";
        SeminarJnlLine."Starting Date" := CSDSeminarRcptHdr."Starting Date";
        SeminarJnlLine."Seminar Registration No." := CSDSeminarRcptHdr."Seminar Registration No.";
        SeminarJnlLine."Room Resource No." := CSDSeminarRcptHdr."Room Resource No.";
        SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := CSDSeminarRcptHdr."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := CSDSeminarRcptHdr."Reason Code";
        SeminarJnlLine."Posting No. Series" := CSDSeminarRcptHdr."Posting No. Series";
        CASE ChargeType OF
            ChargeType::Participant:
                BEGIN
                    SeminarJnlLine."Bill-to-Customer" := CSDSeminarRcptLn."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := CSDSeminarRcptLn."Participant Contact No.";
                    SeminarJnlLine."Participant Name" := CSDSeminarRcptLn."Participant Name";
                    SeminarJnlLine.Description := CSDSeminarRcptLn."Participant Name";
                    SeminarJnlLine.Type := SeminarJnlLine.Type::"G/L Account";
                    SeminarJnlLine.Chargeable := CSDSeminarRcptLn."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := CSDSeminarRcptLn.Amount;
                    SeminarJnlLine."Total Price" := CSDSeminarRcptLn.Amount;
                END;

        END;

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    END;

    procedure PostReceipt(ReceiptHeader: Record "CSD Seminar Receipt Header")
    var
        GenJnlln: Record "Gen. Journal Line";
        LineNo: Integer;
        MaxLineNo: Integer;
        ReceiptLine: Record "CSD Seminar Receipt Line";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange("Receipt No.", ReceiptHeader."Receipt No.");
        ReceiptLine.SetRange("Document No.", ReceiptHeader."Document No.");

        GenJnlln.Reset();
        GenJnlln.SetRange("Journal Template Name", 'SEMINAR');
        GenJnlln.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJnlln.FindLast() then
            MaxLineNo := GenJnlln."Line No.";

        LineNo := MaxLineNo;

        if ReceiptLine.FindSet() then begin
            repeat
                if ReceiptLine.Balance > 0 then begin
                    LineNo += 1;
                    GenJnlln.Init();
                    GenJnlln."Journal Template Name" := 'SEMINAR';
                    GenJnlln."Journal Batch Name" := 'DEFAULT';
                    GenJnlln."Line No." := LineNo;
                    GenJnlln."Document No." := ReceiptHeader."Document No." + '.' + ReceiptHeader."Receipt No.";
                    GenJnlln."Posting Date" := ReceiptHeader."Posting Date";
                    GenJnlln."Account Type" := GenJnlln."Account Type"::Customer;
                    GenJnlln.Validate("Account No.", ReceiptLine."Bill-to Customer No.");
                    GenJnlln.Description := StrSubstNo('Outstanding Balance for Seminar fee for Document No. %1 and Receipt %2', ReceiptHeader."Document No.", ReceiptHeader."Receipt No.") + Format(Date2DMY(CalcDate('-1Y', Today), 3));
                    GenJnlln.Validate(Amount, -ReceiptLine.Balance);
                    GenJnlln."Bal. Account Type" := GenJnlln."Bal. Account Type"::"G/L Account";
                    GenJnlln."Bal. Account No." := '19159';
                    GenJnlln."Currency Code" := '';
                    GenJnlln.Insert();
                end;
            until ReceiptLine.Next() = 0;
            if GenJnlln.Find('-') then
                codeunit.Run(codeunit::"Gen. Jnl.-Post Batch", GenJnlln);
        end;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable := not Rec.Posted;
    end;
}
