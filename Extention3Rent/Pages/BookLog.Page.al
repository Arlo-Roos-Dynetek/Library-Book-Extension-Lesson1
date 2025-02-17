/// <summary>
/// Page Book Renting Log (ID 50311).
/// </summary>
page 50311 "Book Renting Log"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Book Log Table";
    Editable = false;
    SourceTableView = order(descending);
    layout
    {
        area(Content)
        {
            repeater("Renting & Returning Log")
            {
                field(LogID; Rec.LogID)
                {

                }
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
            action("Filter according to book")
            {
                Image = Filter;
                trigger OnAction()
                var
                    BookLogTable: Record "Book Log Table";
                begin
                    Rec.SetFilter("Book Title", rec."Book Title");

                    CurrPage.Update();
                end;
            }
            action("Clear Filter")
            {
                Image = ClearFilter;
                trigger OnAction()
                var

                begin
                    Rec.Reset();
                    CurrPage.Update();
                end;
            }
        }
    }


}