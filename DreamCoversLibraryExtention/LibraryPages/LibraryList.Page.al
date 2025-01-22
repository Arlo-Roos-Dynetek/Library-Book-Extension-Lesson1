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

                field(Title; Rec.Title)//TODO sit application area by
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
                begin
                    Page.RunModal(Page::"Rent Book", Rec);
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
                    RentErrorMessage:= 'Sorry, this book is already rented :(';
                    if Rec.Rented = false then begin

                        rentCode.ValidateRentInfo(Rec);
                    end
                    else
                        Message(RentErrorMessage);//TODO Vervang met a label
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
             action(" Open Grouped Book Info Page")
            {
                Image = Add;
                trigger OnAction()
                
                begin
                   // Page.RunModal(Page::"Grouped Book Info", Rec);
                end;
            }
        }
    }

}