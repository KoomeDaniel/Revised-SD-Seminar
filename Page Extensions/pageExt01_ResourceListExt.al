pageextension 50101 "CSD ResourceListExt" extends "Resource List"
{
    // This defines a page extension for the "Resource List" page, with the ID 50101 and name "CSD ResourceListExt".

    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        // Modifies the visibility of the "Type" field based on the value of the "ShowType" Boolean variable.

        addafter(Type)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type") { }
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
            {
                Visible = ShowMaxField;
            }
        }
        // Adds two fields, "CSD Resource Type" and "CSD Maximum Participants", after the "Type" field in the layout.
        // The visibility of "CSD Maximum Participants" is controlled by the Boolean variable "ShowMaxField".
    }

    trigger OnOpenPage()
    begin
        ShowType := (Rec.GetFilter(Type) = '');
        ShowMaxField := (Rec.GetFilter(Type) = format(Rec.Type::machine));
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
