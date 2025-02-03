tableextension 50100 GenreTableExt extends "Genre List"
{
    fields
    {
        field(50101; "Genre ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Genre List".ID;
        }
    }
}
