pageextension 50100 "ResoureCardExt" extends "Resource Card"
{
    // This defines a page extension for the "Resource Card" page, with the ID 50100 and name "ResoureCardExt".

    layout
    {
        addlast(General)// The addlast(General) part specifies that the new fields will be added at the end of the “General” group on the page.
        {
            field("CSD Resource Type"; Rec."CSD Resource Type") { }//This line adds a new field to the page layout. The field is named "CSD Resource Type" and it is bound to the "CSD Resource Type" field in the current record (Rec). The {} indicates that there are no additional properties or customizations for this field.
            field("CSD Quantity per Day"; Rec."CSD Quantity per Day") { }//Similarly, this line adds another field to the page layout. The field is named "CSD Quantity per Day" and it is bound to the "CSD Quantity per Day" field in the current record (Rec). Again, the {} indicates no additional properties or customizations.
        }
        // Adds two new fields, "CSD Resource Type" and "CSD Quantity per Day", to the end of the "General" section
        // in the layout of the Resource Card page.

        addafter("Personal Data")//This line specifies that the new elements will be added after the “Personal Data” group on the page.
        {
            group("CSD Room")// This line defines a new group named "CSD Room". Groups are used to organize fields on a page, making it easier for users to navigate and understand the data.
            {
                Caption = 'Room';//This sets the caption (or label) for the group to 'Room'
                field("CSD Maximum Participants"; Rec."CSD Maximum Participants") { }//This line adds a new field to the page layout. The field is named "CSD Maximum Participants" and it is bound to the "CSD Maximum Participants" field in the current record (Rec). The {} indicates that there are no additional properties or customizations for this field.
            }
        }
        // Adds a new group titled "CSD Room" after the "Personal Data" section in the layout, containing the
        // "CSD Maximum Participants" field.
    }

    trigger OnAfterGetRecord()//This is an event trigger that runs after a record has been retrieved from the database and is ready to be displayed on the page.
    begin
        ShowMaxField := (Rec.Type = Rec.Type::Machine);//This line sets the value of the ShowMaxField variable. It checks if the Type field of the Resource table is equal to Machine. If it is, ShowMaxField is set to true; otherwise, it is set to false.
        CurrPage.Update(false);//This line updates the current page. The false parameter indicates that the page should be updated without refreshing the entire page, which can improve performance.
    end;
    // Trigger event that runs after the page retrieves a record. It sets the Boolean variable "ShowMaxField" to true
    // if the "Type" field on the record equals "Machine". Then it updates the page without modifying the current record.

    var
        [InDataSet]
        ShowMaxField: Boolean;
    // This Boolean variable, "ShowMaxField", is declared and will be used to control the visibility of certain fields.
}
