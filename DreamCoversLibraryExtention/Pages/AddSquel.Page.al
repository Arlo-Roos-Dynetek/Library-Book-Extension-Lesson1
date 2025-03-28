page 50128 Sequel
{
    // this page is used to display the fields that the user will use to enter the data of the book they want to add.
    // this page is also used to call the relevant procedures.
    
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = Library;
    CardPageID = "Book Info";
    layout
    {
        area(Content)
        {
            group("Main Details")
            {

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                }
                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }
            }
            group("Extra Details")
            {
                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                }
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }
                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                }
                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}