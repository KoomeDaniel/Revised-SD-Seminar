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
        UserId: Code[50];
    begin
        SemJnlLine.TestField("Posting Date");

        // Handle User Setup and GL Setup logic for Allow Posting Dates
        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.GET(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;

            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                GLSetup.GET;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;

            if AllowPostingTo = 0D then
                AllowPostingTo := DMY2Date(31, 12, 9999);
        end;

        if (SemJnlLine."Posting Date" < AllowPostingFrom) OR (SemJnlLine."Posting Date" > AllowPostingTo) then
            SemJnlLine.FieldError("Posting Date", PostingDateTxt);

        // Handle Document Date
        if SemJnlLine."Document Date" <> 0D then begin
            if SemJnlLine."Document Date" = CLOSINGDATE(SemJnlLine."Document Date") then
                SemJnlLine.FieldError("Document Date", ClosingDateTXT);
        end;

        // Additional check for Posting Date being a closing date
        if SemJnlLine."Posting Date" <> NormalDate(SemJnlLine."Posting Date") then
            SemJnlLine.FieldError("Posting Date", ClosingDateTXT);

        UserSetupManagement.CheckAllowedPostingDate(SemJnlLine."Posting Date");
    end;
}
