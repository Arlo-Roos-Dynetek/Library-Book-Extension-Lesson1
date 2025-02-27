table 50331 "Library Inventory Cue"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; PrimaryKey; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Books added in past Month"; Integer)
        {
            Caption = 'Books added in past Month';
            ToolTip = 'THis Cue shows the amount of books that have been added in the last month.';
            FieldClass = FlowField;
            CalcFormula = count(Library where("Date Added" = filter('t-1M..t')));
        }
    }

    keys
    {
        key(Key1; PrimaryKey)
        {
            Clustered = true;
        }
    }
}