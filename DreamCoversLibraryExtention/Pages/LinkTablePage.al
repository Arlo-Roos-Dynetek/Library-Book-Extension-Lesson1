page 50102 "Link Table Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Link Table";
    
    layout
    {
        area(Content)
        {
            repeater(Details)
            {
               
                field(AuthorID; Rec.AuthorID)
                {
                    ToolTip = 'Specifies the value of the AuthorID field.', Comment = '%';
                }
                field(BookID; Rec.BookID)
                {
                    ToolTip = 'Specifies the value of the BookID field.', Comment = '%';
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