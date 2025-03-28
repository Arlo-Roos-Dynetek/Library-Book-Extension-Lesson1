table 50101 "Link Table"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;BookID;Code[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(10;AuthorID;Code[20])
        {
            DataClassification = ToBeClassified;
            
        }
    }
    
    keys
    {
        key(Key1; BookID,AuthorID)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}