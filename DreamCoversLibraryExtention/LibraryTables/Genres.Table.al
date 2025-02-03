table 50102 "Genre List"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Genre"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}
