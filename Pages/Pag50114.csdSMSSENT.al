page 50114 "csd SMS SENT"
{
    ApplicationArea = All;
    Caption = 'csd SMS SENT';
    PageType = ListPart;
    SourceTable = "csd sms sent";
    SourceTableView = where(Direction = const(Sent));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.', Comment = '%';
                    Importance = Promoted;//This property specifies the importance of the field. In this case, it’s set to Promoted, which means the field will be displayed more prominently in the user interface.
                    AssistEdit = true;//This makes the field editable with assistance, meaning users can interact with the field to manually select or change its value
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();//This trigger runs when the user clicks the assist-edit button next to the field. The procedure checks if the record allows for assist-editing (Rec.AssistEdit) and updates the current page if successful (CurrPage.Update()).
                    end;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
                field("Message Text"; Rec."Message Text")
                {
                    ToolTip = 'Specifies the value of the Message Text field.', Comment = '%';
                }
                field("Date Time"; Rec."Date Time")
                {
                    ToolTip = 'Specifies the value of the Date Time field.', Comment = '%';
                }
                field(Direction; Rec.Direction)
                {
                    ToolTip = 'Specifies the value of the Direction field.', Comment = '%';
                }
            }
        }
    }
}
