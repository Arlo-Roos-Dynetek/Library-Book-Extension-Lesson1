page 50311 "Book Renting Log"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Book Log Table";

    layout
    {
        area(Content)
        {
            repeater("Renting & Returning Log")
            {
                field("Book Title"; Rec."Book Title")
                {

                }
                field("Customer Name"; Rec."Customer Name")
                {

                }
                field(Action; Rec.Action)
                {
                    Caption = 'Rented/Returned';
                }
                field("Rent Duration"; Rec."Rent Duration")
                {
                    Caption = 'Rent Duration (Days)';
                }
                field("Date Rented"; Rec."Date Rented")
                {

                }
                field("Date Returned"; Rec."Date Returned")
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}