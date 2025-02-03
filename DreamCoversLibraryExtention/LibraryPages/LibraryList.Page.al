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
    ModifyAllowed = false;
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


                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;

                }
                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;

                }
                field("Date Rented";Rec."Date Rented")
                {
                    ApplicationArea = All;

                }
                // field("Date Returned";Rec."Date Returned")
                // {
                //     ApplicationArea = All;

                // }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;

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
                ToolTip = 'This action will display a pop up message that will show you what the top 3 most rented books are.';
                Image = AvailableToPromise;
                trigger OnAction()
                var
                    "Most Rented": Codeunit "Most Rented";
                begin
                    "Most Rented".Run();
                end;
            }

            action("Add Book")
            {
                ToolTip = 'This action will take you to a page where you can add a new book';
                Image = AddContacts;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Add books code");
                end;
            }
            action("Published in past 2 years")
            {
                ToolTip = 'This action will filter through all the books and display all the books that have been published in the last 2 years.';
                Image = Filter;
                trigger OnAction()
                var
                    FilterCode: Codeunit "Library Functionality";
                begin
                    FilterCode.FilterDates(Rec);
                    CurrPage.Update();
                end;
            }
            action("Add Sequel")
            {
                ToolTip = 'This action will take you to a page where you can add a new sequel';
                Image = Add;
                trigger OnAction()
                var
                    AddSequel: Codeunit "Library Functionality";
                begin
                    AddSequel.Navigate_AddSequel(Rec);
                end;
            }
            

        }
    }
    var
    //"Genre List": Enum "Genre List";
}