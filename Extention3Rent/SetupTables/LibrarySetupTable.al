table 50301 "Library table Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }

        field(10; Fines; Decimal)
        {
            Caption = 'Fines';
            ToolTip = 'This field shows the outstanding fine for having an Book that is overdue.';
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}