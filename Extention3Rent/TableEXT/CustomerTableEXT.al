tableextension 50303 "Customer Table EXT" extends Customer
{
    fields
    {
        field(400; Status; Enum "Status Levels")
        {
            Caption = 'Current Status';
        }
        field(401; "Highest Status"; Enum "Status Levels")
        {
            Caption = 'Highest Status';
            ToolTip = 'This field shows the highest status reached by a customer';
        }
        field(402; "Fines"; Decimal)
        {
            Caption = 'Fines';
            ToolTip = 'This field shows the fines that are outstanding for the specific customer';
        }
        field(403; "Allow Rent"; Boolean)
        {
            Caption = 'Allow Rent';
            ToolTip = 'This field shows if the customer is allowed to rent a book or not.';
        }
        field(404; "Probation Period"; Date)
        {
            Caption = 'Probation Period';
            ToolTip = 'This shows the Date when the Customer is allowed to start renting books again';
        }
        field(405; "Mild Counter"; Integer)
        {
            Caption = 'Mild Counter';
            ToolTip = 'THis is used to keep track of the amount of books the customer is allowed to rent with the "Mild" Status';
            InitValue = 0;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}