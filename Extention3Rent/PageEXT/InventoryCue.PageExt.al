pageextension 50330 "Library Inventory Page" extends "Business Manager Role Center"
{
    layout
    {
        addafter(Control139) // Add changes to page layout here
        {
            part("Library Inventory Page"; "Library Inventory Page")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        addfirst(creation)
        {
            action("Go to Dashboard")
            {
                ApplicationArea = all;
                Caption = 'Go to Dashboard';
                RunObject = Page "Dashboard Page";
                RunPageMode = View;

            }
            action("Open Library List")
            {
                ApplicationArea = all;
                Caption = 'Open Library List';
                RunObject = Page "List Of Books";
                RunPageMode = View;

            }
        }

    }


    var
        myInt: Integer;
}