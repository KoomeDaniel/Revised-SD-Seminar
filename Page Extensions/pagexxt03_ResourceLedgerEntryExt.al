pageextension 50103 "CSD Resource Ledger Entry Ext" extends "Resource Ledger Entries"
{
    layout
    {
        addlast(content)
        {
            field("CSD Seminar No."; Rec."CSD Seminar No.")
            {
                ApplicationArea = All;
            }
            field("CSD Seminar Registration No."; Rec."CSD Seminar Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}