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
                ToolTip = '';
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
                // Caption = 'haha';
                Image = Filter;
                ApplicationArea = all;
                trigger OnAction()
                var
                    "Rent Functionality": Codeunit "Rent Functionality";
                begin
                    "Rent Functionality".ShowAllOverdueBooks(Rec);
                end;
            }
            action("Change Fine Amount")
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
                //  RentFunctionality: Codeunit "Rent Functionality";
                begin
                    BookRentingLog.Run();
                    //    RentFunctionality.ShowLogPage(Rec);
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
        }


    }

}