pageextension 50102 "CSD SourceCode Setup Ext" extends "Source Code Setup"
{
    layout
    {
        addafter("Cost Accounting")
        {
            group("CSD SeminarGroup")
            {
                Caption = 'Seminar';
                field("CSD Seminar"; Rec."CSD Seminar")
                { }
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