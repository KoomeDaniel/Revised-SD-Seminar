codeunit 50131 "CSD Seminar Jnl.-Check Line"
{
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClosingDateTXT: Label 'Cannot be a closing date';
        PostingDateTxt: Label 'is not within your range of allowed posting dates.';

    procedure RunCheck(var SemJnlLine: Record "CSD Seminar Journal Line")
    begin
        if SemJnlLine.EmptyLine then
            exit;

        SemJnlLine.TestField("Posting Date");
        SemJnlLine.TestField("Instructor Resource No.");
        SemJnlLine.TestField("Seminar No.");

        case SemJnlLine."Charge Type" of
            SemJnlLine."Charge Type"::Instructor:
                SemJnlLine.TestField("Instructor Resource No.");
            SemJnlLine."Charge Type"::Room:
                SemJnlLine.TestField("Room Resource No.");
            SemJnlLine."Charge Type"::Participant:
                SemJnlLine.TestField("Participant Contact No.");
        end;

        if SemJnlLine.Chargeable then
            SemJnlLine.TestField("Bill-to-Customer");

        // Check dates using a single procedure
        CheckDates(SemJnlLine);
    end;

    local procedure CheckDates(SemJnlLine: Record "CSD Seminar Journal Line")
    var
        UserSetupManagement: Codeunit "User Setup Management";
    begin
        SemJnlLine.TestField("Posting Date");
        if SemJnlLine."Posting Date" <> NormalDate(SemJnlLine."Posting Date") then
            SemJnlLine.FieldError("Posting Date", ClosingDateTXT);

        UserSetupManagement.CheckAllowedPostingDate(SemJnlLine."Posting Date");

        if SemJnlLine."Document Date" = 0D then
            exit;

        if SemJnlLine."Document Date" <> NormalDate(SemJnlLine."Document Date") then
            SemJnlLine.FieldError("Document Date", ClosingDateTXT);
    end;
}
