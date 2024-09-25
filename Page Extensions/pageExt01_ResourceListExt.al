pageextension 50101 "CSD ResourceListExt" extends "Resource List"
{
    // This defines a page extension for the "Resource List" page, with the ID 50101 and name "CSD ResourceListExt".

    layout
    {
        modify(Type)
        {
            Visible = ShowType;//This line sets the visibility of the Type field based on the value of the ShowType variable. If ShowType is true, the Type field will be visible on the page. If ShowType is false, the Type field will be hidden.
        }
        // Modifies the visibility of the "Type" field based on the value of the "ShowType" Boolean variable.

        addafter(Type)//This line specifies that the new fields will be added after the Type field on the page.
        {
            field("CSD Resource Type"; Rec."CSD Resource Type") { }//This line adds a new field named "CSD Resource Type" to the page. It is bound to the "CSD Resource Type" field in the current record (Rec). 
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")//This line adds another new field named "CSD Maximum Participants" to the page. It is bound to the "CSD Maximum Participants" field in the current record (Rec).
            {
                Visible = ShowMaxField;//This line sets the visibility of the Type field based on the value of the ShowType variable. If ShowType is true, the Type field will be visible on the page. If ShowType is false, the Type field will be hidden.
            }
        }
        // Adds two fields, "CSD Resource Type" and "CSD Maximum Participants", after the "Type" field in the layout.
        // The visibility of "CSD Maximum Participants" is controlled by the Boolean variable "ShowMaxField".
    }

    trigger OnOpenPage()//This is an event trigger that runs when the page is opened. It allows you to execute code right when the page is loaded.
    begin
        ShowType := (Rec.GetFilter(Type) = '');//It checks if there’s no filter applied to the Type field (meaning the user hasn't selected any specific type yet).If the Type field has no filter (it’s empty or not restricted to a certain value), then ShowType is set to true. If there is a filter (like if the user has selected "Machine" or "Room" specifically), ShowType is set to false.
        ShowMaxField := (Rec.GetFilter(Type) = format(Rec.Type::machine));// It checks if the Type field is filtered to "Machine." If the user has filtered or selected "Machine" as the Type, then ShowMaxField is set to true. If they’ve selected something else (like "Person" or "Room"), ShowMaxField is set to false.
    end;
    // Trigger event that runs when the page is opened. It sets "ShowType" to true if there is no filter on the "Type"
    // field and sets "ShowMaxField" to true if the filter on "Type" is "machine".

    var
        [InDataSet]
        ShowMaxField: Boolean;
        // This Boolean variable controls the visibility of the "CSD Maximum Participants" field.

        [InDataSet]
        ShowType: Boolean;
    // This Boolean variable controls the visibility of the "Type" field.
}
