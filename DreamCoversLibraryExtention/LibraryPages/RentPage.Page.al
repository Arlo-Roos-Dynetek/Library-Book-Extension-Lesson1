page 50124 "Rent Book"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field(Rented; Rec.Rented)
                {
                    Editable = true;
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