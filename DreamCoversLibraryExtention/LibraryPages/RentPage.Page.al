page 50124 "Rent Book"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            group("Rent Book")
            {
                field(Title; Rec.Title)
                {
                    Editable = false;

                }
                field(Author; Rec.Author)
                {
                    Editable = false;
                }
                
                field("Customer Name";Rec."Customer Name")
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

    // trigger OnOpenPage()
    // var
    // ThisPage: Page "Rent Book";
    // begin
    //     if rec.Rented then 
    //     begin
    //     // ThisPage.Close();
    //      // Page.RunModal(Page::"List Of Books", Rec);
    //     end;
    // end;
}