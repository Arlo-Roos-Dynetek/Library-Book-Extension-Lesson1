page 50103 "Author Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = Author;
    CardPageID = "Author Card Page";
    
    layout
    {
        area(Content)
        {
           repeater("Author Details")
            {
                field(Name;Rec.Name)
                {
                    // DrillDownPageId = "Author Card Page";
                }
            }
        }
    }
    
  
}