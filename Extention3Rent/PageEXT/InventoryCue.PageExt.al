pageextension 50330 "Library Inventory Page" extends "Business Manager Role Center"
{
    layout
    {
        addafter(Control139) // Add changes to page layout here
        {
            part("Library Inventory Page"; "Library Inventory Page")
            {

            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("Go to Dashboard")
            {
                Caption = 'Go to Dashboard';
                RunObject = Page "Dashboard Page";
                RunPageMode = View;
            }
        }
    }

    var
        myInt: Integer;
}