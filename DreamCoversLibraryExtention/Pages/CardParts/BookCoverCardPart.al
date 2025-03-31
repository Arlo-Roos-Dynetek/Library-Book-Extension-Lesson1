page 50105 "Book Info Card Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    
    layout
    {
        area(Content)
        {
            group(CoverPart)
            {
                ShowCaption= false;
                field("Book Cover";Rec."Book Cover")
                {
                    Caption='Book Cover';
                }
            }
        }
    }
    
  
}