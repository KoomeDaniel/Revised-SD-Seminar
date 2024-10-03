codeunit 50141 "CSD Seminar PostYesNo"
{
    TableNo = "CSD Registration Header";

    trigger OnRun()
    begin
        SeminarRegHeader.COPY(Rec);
        Code;
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record "CSD Registration Header";
        SeminarPost: Codeunit "CSD Seminar Post";
        ContinuePostingQst: Label 'Continue to post Seminar Registration No.: %1?';

    local procedure "Code"();
    begin
        if NOT Confirm(ContinuePostingQst, FALSE, SeminarRegHeader."No.") then
            exit;
        SeminarPost.Run(SeminarRegHeader);
        COMMIT;
    end;
}
