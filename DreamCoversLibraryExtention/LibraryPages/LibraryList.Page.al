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
                field(BookID; Rec.BookID)
                {
                    Visible = false;
                    //  TableRelation = Library.BookID;

                }

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

                field(Genre; Rec.Genre)
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
                Image = AvailableToPromise;
                trigger OnAction()
                var
                    MostRented: Codeunit "Most Rented";
                begin
                    MostRented.Run();
                    Page.RunModal(Page::"Rent Book", Rec);
                end;
            }
            action("Rent Book")
            {
                Image = AddWatch;
                trigger OnAction()
                var
                    rentCode: Codeunit "Rent Book";
                begin
                    if Rec.Rented = false then begin

                        rentCode.ValdateRentInfo(Rec);
                    end
                    else
                        Message('Sorry, this book is already rented :(');
                end;
            }
            action("Add Book")
            {
                Image = AddContacts;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Add books code");
                end;
            }
            action("Filter: Published in past 2 years")
            {
                Image = Filter;
                trigger OnAction()
                var
                    FilterCode: Codeunit "Filter With Dates";
                begin
                    FilterCode.FilterDates(Rec);
                    CurrPage.Update();
                end;
            }
            action("Add Sequel")
            {
                Image = Add;
                trigger OnAction()
                var
                    AddSequel: Codeunit "SequelCode";
                begin
                    AddSequel.Navigate_AddSequel(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}