page 50104 "Book Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = Library;
    CardPageID = "Book Info";
    
    layout
    {
        area(Content)
        {
           repeater("Book Details")
            {
                field(Title;Rec.Title)
                {
                //  DrillDownPageId = "Book Info";   
                }
            }
        }
    }

}