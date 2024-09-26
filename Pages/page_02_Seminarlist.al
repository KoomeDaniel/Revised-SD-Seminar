page 50102 "CSD Seminar List"
{
    Caption = 'Seminar List';
    CardPageId = 50101;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "CSD SEMINAR";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                }
                field("Maximum Participants"; Rec."Maximum Participants")
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