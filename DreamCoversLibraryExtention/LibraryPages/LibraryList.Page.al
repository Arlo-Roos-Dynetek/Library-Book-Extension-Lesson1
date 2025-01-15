page 50120 "List Of Books"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Library Page';
    SourceTable = Library;
    CardPageID = "Book Info";

    layout
    {
        area(Content)
        {
            repeater("List of Books")
            {
                // field(BookID; Rec.BookID)
                // {
                //     Editable = true;
                //   //  TableRelation = Library.BookID;

                // }

                field(Title; Rec.Title)
                {
                    Editable = true;

                }
                field(Author; Rec.Author)
                {
                    Editable = true;
                }
                field(Rented; Rec.Rented)
                {
                    Editable = true;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }
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
                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Most Rented")
            {

                trigger OnAction()
                var
                    MostRented: Codeunit "Most Rented";
                begin
                    MostRented.Run();
                    Page.RunModal(Page::"Rent Book", Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}