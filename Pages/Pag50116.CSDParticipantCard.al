page 50116 "CSD Participant Card"
{
    ApplicationArea = All;
    Caption = 'CSD Participant Card';
    PageType = Card;
    SourceTable = "CSD Participant ";

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Participant ID"; rec."Participant ID")
                {
                    Importance = Promoted;//This property specifies the importance of the field. In this case, it’s set to Promoted, which means the field will be displayed more prominently in the user interface.
                    AssistEdit = true;//This makes the field editable with assistance, meaning users can interact with the field to manually select or change its value
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();//This trigger runs when the user clicks the assist-edit button next to the field. The procedure checks if the record allows for assist-editing (Rec.AssistEdit) and updates the current page if successful (CurrPage.Update()).
                    end;
                }
                field("Name"; rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Email"; rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; rec."Phone Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Save")
            {
                ApplicationArea = All;
                Caption = 'Save';
                trigger OnAction()
                begin
                    CurrPage.SaveRecord;
                end;
            }
            action("Send SMS")
            {
                ApplicationArea = All;
                Caption = 'Send SMS';
                trigger OnAction()
                var
                    ParticipantSMSProcessor: Codeunit "Participant SMS Processor";
                begin
                    Rec.Reset();
                    ParticipantSMSProcessor.SendSMS(Rec."Participant ID", Rec.Name, Rec."Phone Number");

                end;
            }
        }
    }
}
