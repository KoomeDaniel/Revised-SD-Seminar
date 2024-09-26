page 50101 "CSD SEMINAR CARD"
{
    Caption = 'Seminar Card';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "CSD SEMINAR";

    layout
    {
        area(Content)//This is the main content area of the page where you display fields (data from the seminar table).
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    AssistEdit = true;//This makes the field editable with assistance, meaning users can interact with the field to manually select or change its value
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then
                            CurrPage.Update();//This trigger runs when the user clicks the assist-edit button next to the field. The procedure checks if the record allows for assist-editing (Rec.AssistEdit) and updates the current page if successful (CurrPage.Update()).
                    end;

                }
                field(Name; Rec.Name)
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                }
            }
        }


        area(FactBoxes)//This section defines extra information on the side of the page, typically FactBoxes, such as notes or links related to the seminar.
        {
            systempart("Links"; Links)//This adds a FactBox to the page, which shows links related to the seminar. FactBoxes appear on the side of the page and provide additional information.
            {

            }
            systempart("Notes"; Notes)//This adds another FactBox that allows users to view or add Notes related to the seminar.
            {

            }
        }
    }
    actions
    {
        area(Navigation)//Defines an area where the actions will be placed. In this case, it’s the Navigation area, which is typically used for navigation-related actions.
        {
            group("&Seminar")//Defines a group of actions under the label “Seminar”. The & character is used to create a keyboard shortcut (Alt + S) for this group.

            {
                action("Co&mments")//Defines an action with the label “Comments”. The & character creates a keyboard shortcut (Alt + M) for this action.
                {
                    //RunObject=page "CSD Seminar Comment Sheet";//specify that the action should open the “CSD Seminar Comment Sheet” page when executed.
                    // RunPageLink = "Table Name"=const(Seminar),"No."=field("No.");//link the current record to the “CSD Seminar Comment Sheet” page, filtering it by the “Table Name” and “No.” fields.
                    Image = Comment;//Specifies the icon to be used for the action. In this case, it uses the “Comment” icon.
                    Promoted = true;//Indicates that this action should be promoted, meaning it will be more prominently displayed in the user interface.
                    PromotedIsBig = true;//Specifies that the promoted action should be displayed with a larger icon.
                    PromotedOnly = true;//Indicates that this action should only be shown in the promoted area and not in the regular action menu.
                }
            }
        }
    }




}