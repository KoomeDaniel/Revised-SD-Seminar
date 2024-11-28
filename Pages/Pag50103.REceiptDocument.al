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
                    Importance = Promoted;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    ToolTip = 'Specifies the value of the Seminar Registration No. field.', Comment = '%';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.', Comment = '%';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ToolTip = 'Specifies the value of the Participant Contact No. field.', Comment = '%';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the Participant Name field.', Comment = '%';
                }
                field("Total Deposit Amount"; Rec."Total Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Total Deposit Amount field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the phone number of the participant.';
                    trigger OnValidate()
                    begin
                        if rec."Phone Number" <> '' then begin
                            if COPYSTR(rec."Phone Number", 1, 1) = '0' then
                                rec."Phone Number" := '+254' + COPYSTR(rec."Phone Number", 2);
                        end;
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                    Editable = false;
                }
            }
            part("Receipt Line"; "CSD Seminar Receipt subform")
            {
                ApplicationArea = All;
                Caption = 'Receipt Line';
                SubPageLink = "Document No." = field("Document No."), "Receipt No." = field("Receipt No.");
                UpdatePropagation = Both;
            }
            field("Total Receipt Lines"; Rec."Total Receipt Lines")
            {
                ToolTip = 'Specifies the value of the Total Receipt Lines field.', Comment = '%';
            }
        }
        area(Factboxes)
        {
            part(SeminarDetails; "CSD Seminar Details Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
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
                        if Rec."Total Receipt Lines" <> Rec."Total Deposit Amount" then
                            Error('The Total Receipt Lines and Total Deposit Amount must be equal.');

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
                            // PostReceipt(Rec);
                            UNTIL CSDSeminarRcptLn.NEXT = 0;

                            CSDSeminarRegnLn.Reset();
                            CSDSeminarRegnLn.SetRange("Document No.", Rec."Document No.");
                            if CSDSeminarRegnLn.FindLast() then
                                RegMaxLineNo := CSDSeminarRegnLn."Line No."
                            else
                                RegMaxLineNo := 0;

                            RegLineNo := RegMaxLineNo + 1;

                            CSDSeminarRegnLn.Reset();
                            CSDSeminarRegnLn.SetRange("Document No.", Rec."Document No.");
                            CSDSeminarRegnLn.SetRange("Participant Contact No.", Rec."Participant Contact No.");

                            if CSDSeminarRegnLn.FindFirst() then begin
                                // Update existing registration line
                                CSDSeminarRegnLn.Balance := CSDSeminarRcptHdr.Balance;
                                CSDSeminarRegnLn."Amount Paid" := CSDSeminarRegnLn."Amount Paid" + CSDSeminarRcptHdr."Total Receipt Lines";
                                CSDSeminarRegnLn.Modify();
                            end else begin
                                // Insert new registration line
                                CSDSeminarRegnLn.Init();
                                CSDSeminarRegnLn."Document No." := Rec."Document No.";
                                CSDSeminarRegnLn."Line No." := RegLineNo;
                                CSDSeminarRegnLn."Bill-to Customer No." := Rec."Bill-to Customer No.";
                                CSDSeminarRegnLn."Participant Contact No." := Rec."Participant Contact No.";
                                CSDSeminarRegnLn."Participant Name" := Rec."Participant Name";
                                CSDSeminarRegnLn."Registration Date" := CSDSeminarRcptLn."Registration Date";
                                CSDSeminarRegnLn."To Invoice" := CSDSeminarRcptLn."To Invoice";
                                CSDSeminarRegnLn.Participated := CSDSeminarRcptLn.Participated;
                                CSDSeminarRegnLn."Confirmation Date" := CSDSeminarRcptLn."Confirmation Date";
                                CSDSeminarRegnLn."Seminar Price" := CSDSeminarRcptLn."Seminar Price";
                                CSDSeminarRegnLn."Line Discount %" := CSDSeminarRcptLn."Line Discount %";
                                CSDSeminarRegnLn.Amount := CSDSeminarRcptLn.Amount;
                                CSDSeminarRegnLn.Registered := true;
                                CSDSeminarRegnLn."Amount Paid" := CSDSeminarRcptHdr."Total Receipt Lines";
                                CSDSeminarRegnLn.Balance := CSDSeminarRcptHdr.Balance;
                                CSDSeminarRegnLn.Description := rec."Document No.";
                                CSDSeminarRegnLn.Insert();
                            end;


                            Rec.Posted := TRUE;
                            rec.Modify();
                            Commit();


                            if CSDRegnHdr.Get(Rec."Document No.") then begin
                                CSDRegnHdr.Status := CSDRegnHdr.Status::Registration;
                                CSDRegnHdr.Modify();
                            end;
                            SendReceiptPostingEmail(Rec);
                            SendSMS(Rec);

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
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Label 'Dear <b>%1</b>,<br> <p>Thank you for registering for the %2 Seminar Starting on %3.</p><hr>';


    LOCAL PROCEDURE PostSeminarJnlLine(ChargeType: Option Instructor,Room,Participant,Charge)
    BEGIN
        SeminarJnlLine.INIT;
        SeminarJnlLine."Seminar No." := CSDSeminarRcptHdr."Seminar No.";
        SeminarJnlLine."Posting Date" := CSDSeminarRcptHdr."Posting Date";
        SeminarJnlLine."Document Date" := CSDSeminarRcptHdr."Document Date";
        SeminarJnlLine."Document No." := CSDSeminarRcptHdr."Seminar Registration No." + '.' + CSDSeminarRcptHdr."Participant Contact No.";
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
                    SeminarJnlLine."Transaction Type" := CSDSeminarRcptLn."Transaction Type";
                    SeminarJnlLine.Required := CSDSeminarRcptLn.Required;
                    SeminarJnlLine."Amount Paid" := CSDSeminarRcptLn."Amount Paid";
                    SeminarJnlLine.Balance := CSDSeminarRcptLn.Balance;
                END;
        END;
        // MESSAGE('Processing line: %1, Amount: %2, Type: %3', CSDSeminarRcptLn."Line No.", CSDSeminarRcptLn."Amount Paid", CSDSeminarRcptLn."Transaction Type");

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    END;

    // procedure PostReceipt(ReceiptHeader: Record "CSD Seminar Receipt Header")
    // var
    //     GenJnlln: Record "Gen. Journal Line";
    //     LineNo: Integer;
    //     MaxLineNo: Integer;
    //     ReceiptLine: Record "CSD Seminar Receipt Line";
    // begin
    //     ReceiptLine.Reset();
    //     ReceiptLine.SetRange("Receipt No.", ReceiptHeader."Receipt No.");
    //     ReceiptLine.SetRange("Document No.", ReceiptHeader."Document No.");

    //     GenJnlln.Reset();
    //     GenJnlln.SetRange("Journal Template Name", 'SEMINAR');
    //     GenJnlln.SetRange("Journal Batch Name", 'DEFAULT');
    //     if GenJnlln.FindLast() then
    //         MaxLineNo := GenJnlln."Line No.";

    //     LineNo := MaxLineNo;

    //     if ReceiptLine.FindSet() then begin
    //         repeat
    //             if ReceiptLine.Balance > 0 then begin
    //                 LineNo += 1;
    //                 GenJnlln.Init();
    //                 GenJnlln."Journal Template Name" := 'SEMINAR';
    //                 GenJnlln."Journal Batch Name" := 'DEFAULT';
    //                 GenJnlln."Line No." := LineNo;
    //                 GenJnlln."Document No." := ReceiptHeader."Document No." + '.' + ReceiptHeader."Receipt No.";
    //                 GenJnlln."Posting Date" := ReceiptHeader."Posting Date";
    //                 GenJnlln."Account Type" := GenJnlln."Account Type"::Customer;
    //                 GenJnlln.Validate("Account No.", ReceiptLine."Bill-to Customer No.");
    //                 GenJnlln.Description := StrSubstNo('Outstanding Balance for Seminar fee for Document No. %1 and Receipt %2', ReceiptHeader."Document No.", ReceiptHeader."Receipt No.") + Format(Date2DMY(CalcDate('-1Y', Today), 3));
    //                 GenJnlln.Validate(Amount, -ReceiptLine.Balance);
    //                 GenJnlln."Bal. Account Type" := GenJnlln."Bal. Account Type"::"G/L Account";
    //                 GenJnlln."Bal. Account No." := '19159';
    //                 GenJnlln."Currency Code" := '';
    //                 GenJnlln.Insert();
    //             end;
    //         until ReceiptLine.Next() = 0;
    //         if GenJnlln.Find('-') then
    //             codeunit.Run(codeunit::"Gen. Jnl.-Post Batch", GenJnlln);
    //     end;

    // end;

    procedure SendReceiptPostingEmail(CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header")
    begin
        EmailMsg.Create(CSDSeminarRcptHdr."Participant E-mail", CSDSeminarRcptHdr."Participant Name" + ' Seminar Receipt Posting', '', true);
        EmailMsg.AppendToBody(StrSubstNo(EmailBody, CSDSeminarRcptHdr."Participant Name", CSDSeminarRcptHdr."Seminar Name", CSDSeminarRcptHdr."Starting Date"));
        email.Send(EmailMsg);
    end;

    procedure SendSMS(CSDSeminarRcptHdr: Record "CSD Seminar Receipt Header")
    var
        ParticipantSMSProcessor: Codeunit "Participant SMS Processor";
    begin
        ParticipantSMSProcessor.SendSMS(CSDSeminarRcptHdr."Participant Contact No.", CSDSeminarRcptHdr."Participant Name", CSDSeminarRcptHdr."Phone Number");
    end;


    trigger OnOpenPage()
    begin
        CurrPage.Editable := not Rec.Posted;
    end;
}
