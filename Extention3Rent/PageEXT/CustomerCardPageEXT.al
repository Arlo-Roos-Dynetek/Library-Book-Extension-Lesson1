pageextension 50302 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field(Fines; Rec.Fines)
            {
                Caption = 'Fines';
                ToolTip = 'This field displays the fine that the customer needs to pay.';
                Editable = false;
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                Caption = 'Current Status';
                ToolTip = 'This field displays the status regarding outstanding books.';
                ApplicationArea = All;
                // Editable = false;
            }
            field("Highest Status"; Rec."Highest Status")
            {
                Caption = 'Highest Status';
                ToolTip = 'This field displays the highest status that has been reached.';
                ApplicationArea = All;
                //  Editable = false;
            }
            field("Probation Period"; Rec."Probation Period")
            {
                Caption = 'Probation Period';
                ToolTip = 'This date represents when you will be able to rent books again.';
                ApplicationArea = All;
                // Editable = false;
            }
            field("Mild Counter"; Rec."Mild Counter")
            {
                Caption = 'Mild Counter';

                ToolTip = 'This field shows you how many books you have rented on a "Mild" status.';
                ApplicationArea = All;
            }
            field("Allow Rent"; Rec."Allow Rent")
            {
                Caption = 'Allow Rent';

                ToolTip = 'This field shows you if the customer is allowed to rent a book.';
                ApplicationArea = All;
            }
        }

    }


}