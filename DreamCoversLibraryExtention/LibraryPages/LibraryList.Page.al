/// <summary>
/// Page List Of Books (ID 50120).
/// </summary>
page 50120 "List Of Books"
{
    // this page is used to display the list of books that are present in the library.
    // this page is also used to call the relevant procedures.

    PageType = List;
    ApplicationArea = All;
    Caption = 'Library Page';
    SourceTable = Library;
    CardPageID = "Book Info";
    UsageCategory = Lists;
    ModifyAllowed =false;
    layout
    {
        area(Content)
        {
            repeater("List of Books")
            {
                field(BookID; Rec."Book ID")
                {
                    Visible = false;
                    //  TableRelation = Library.BookID;

                }

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
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
                field("Book Price"; Rec."Book Price")
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
                    "Most Rented": Codeunit "Most Rented";
                begin
                    "Most Rented".Run();
                end;
            }
            action("Rent Book")
            {
                Image = AddWatch;
                trigger OnAction()
                var
                    rentCode: Codeunit "Rent Book";
                    RentErrorMessage: Text;
                begin
                    RentErrorMessage := 'Sorry, this book is already rented :(';
                    if Rec.Rented = false then begin

                        rentCode.ValidateRentInfo(Rec);
                    end
                    else
                        Message(RentErrorMessage);
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
            action("Return Book")
            {
                Image = Absence;
                trigger OnAction()
                var
                    "Return Book": Codeunit "Return Book";
                begin
                    "Return Book".ReturnBook(Rec);
                end;
            }

        }
    }
    var
        "Genre List": Enum "Genre List";
}