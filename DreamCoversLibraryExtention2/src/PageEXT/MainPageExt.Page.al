/// <summary>
/// PageExtension MainPageExt (ID 50200) extends Record List Of Books.
/// </summary>
pageextension 50200 MainPageExt extends "List Of Books"
{
    // this is the extension that is used to get to the new page on the new extension
    actions
    {
        addbefore("Most Rented")
        {
            action("Navigate to Grouped information Page")
            {
                Image = RelatedInformation;
                trigger OnAction()
                var
                    GroupedBookInfo: Page "Grouped Book Info";
                begin
                    GroupedBookInfo.Run();
                end;
            }
        }
    }
}