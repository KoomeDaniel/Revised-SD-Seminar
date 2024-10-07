codeunit 50102 "CSD Seminar Reg Printed"
{
    TableNo = "CSD Registration Header";
    trigger OnRun()
    begin
        rec.find;
        rec."No. Printed" += 1;
        rec.Modify;
        Commit;
    end;

    var
        myInt: Integer;
}