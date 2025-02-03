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
            }
            field(Status; Rec.Status)
            {
                Caption = 'Current Status';
                ToolTip = 'This field displays the status regarding outstanding books.';
               // Editable = false;
            }
            field("Highest Status"; Rec."Highest Status")
            {
                Caption = 'Highest Status';
                ToolTip = 'This field displays the highest status that has been reached.';
               //Editable = false;
            }
            field("Probation Period"; Rec."Probation Period")
            {
                Caption = 'Probation Period';
                ToolTip = 'This date represents when you will be able to rent books again.';
            }
        }

    }

}