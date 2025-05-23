/// <summary>
/// PageExtension List Page extention  (ID 50304) extends Record List Of Books.
/// </summary>
pageextension 50304 "List Page extention " extends "List Of Books"
{

    layout
    {

        addbefore(Genre)
        {
            field(Status; Rec.Status)
            {
                Caption = 'Current Status';
                ToolTip = 'This is the current status for the book.';
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                    "Rent Functionality": Codeunit "Rent Functionality";
                begin
                    "Rent Functionality".AssignCustomerLevel();
                end;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {

                Caption = 'Weeks Overdue';
                ToolTip = 'This is the current Weeks overdue for the book.';
                ApplicationArea = All;
            }
            field("Monthly Rank"; Rec."Monthly Rank")
            {
                Caption = 'Monthly Rank';
                ToolTip = 'This field shows the rank the book has been placed at based on the amount of times that has been rented in a months time.';
                ApplicationArea = All;
            }




        }

    }


    actions
    {
        addlast(Navigation)
        {

            action("Overdue Books")
            {
                Image = Filter;
                ApplicationArea = all;
                trigger OnAction()
                var
                    "Rent Functionality": Codeunit "Rent Functionality";
                begin
                    "Rent Functionality".ShowAllOverdueBooks(Rec);
                end;
            }
            action("Change Fixed Data")
            {
                Image = Change;
                ApplicationArea = All;
                trigger OnAction()
                var
                    "Library Page Setup": Page "Library Page Setup";
                begin
                    "Library Page Setup".Run();
                end;
            }
            action("View Rent log")
            {
                Image = ImportLog;
                ApplicationArea = All;
                trigger OnAction()
                var
                    "BookRentingLog": Page "Book Renting Log";
                begin
                    BookRentingLog.Run();
                end;
            }
            action("Update Book Rank")
            {
                Image = Absence;
                ApplicationArea = All;
                trigger OnAction()
                var
                    "RankBooks": Codeunit "Rank books";
                begin
                    RankBooks.ForceRun();
                    CurrPage.Update();
                end;
            }
            action("Go to Dashboard")
            {
                Image = Change;
                ApplicationArea = All;
                trigger OnAction()
                var
                    "DashboardPage": Page "Dashboard Page";
                begin
                    DashboardPage.Run();
                end;
            }
            action("Search New Book")
            {
                Image = Find;
                ApplicationArea = All;
                trigger OnAction()
                var
                    BookSearchAPI: Page "Book Search API";
                begin
                    BookSearchAPI.Run();
                end;
            }

        }


    }

}