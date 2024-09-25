pageextension 50100 "ResoureCardExt" extends "Resource Card"
{
    // This defines a page extension for the "Resource Card" page, with the ID 50100 and name "ResoureCardExt".

    layout
    {
        addlast(General)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type") { }
            field("CSD Quantity per Day"; Rec."CSD Quantity per Day") { }
        }
        // Adds two new fields, "CSD Resource Type" and "CSD Quantity per Day", to the end of the "General" section
        // in the layout of the Resource Card page.

        addafter("Personal Data")
        {
            group("CSD Room")
            {
                Caption = 'Room';
                field("CSD Maximum Participants"; Rec."CSD Maximum Participants") { }
            }
        }
        // Adds a new group titled "CSD Room" after the "Personal Data" section in the layout, containing the
        // "CSD Maximum Participants" field.
    }

    trigger OnAfterGetRecord()
    begin
        ShowMaxField := (Rec.Type = Rec.Type::Machine);
        CurrPage.Update(false);
    end;
    // Trigger event that runs after the page retrieves a record. It sets the Boolean variable "ShowMaxField" to true
    // if the "Type" field on the record equals "Machine". Then it updates the page without modifying the current record.

    var
        [InDataSet]
        ShowMaxField: Boolean;
    // This Boolean variable, "ShowMaxField", is declared and will be used to control the visibility of certain fields.
}
