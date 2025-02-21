/// <summary>
/// PageExtension Rent page Extetion (ID 50301) extends Record List Of Books.
/// </summary>
pageextension 50301 "Rent page Extetion" extends "List Of Books"
{
    actions
    {
        addbefore("Add Book")
        {
            action("Rent Book")
            {
                ToolTip = 'This action will take you to a page where you can rent a book';
                Image = AddWatch;
                ApplicationArea = All;
                trigger OnAction()
                var
                    rentCode: Codeunit "Rent Functionality";
                    RentErrorMessageLbl: Label 'Sorry, this book is already rented :(';
                begin

                    if Rec.Rented = false then
                        rentCode.ValidateRentInfo(Rec)
                    else
                        Message(RentErrorMessageLbl);
                end;
            }
            action("Return Book")
            {
                ToolTip = 'This action will allow you to return the book that you have selected.';
                Image = Absence;
                ApplicationArea = All;
                trigger OnAction()
                var
                    "Return Book": Codeunit "Rent Functionality";
                begin
                    "Return Book".ReturnBook(Rec);
                end;
            }
        }
    }
}