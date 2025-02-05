table 50301 "Library table Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }

        field(10; HighFines; Decimal)
        {
            Caption = ' High Status Fines';
            ToolTip = 'This field shows the what the fine for having an Book that is overdue on High Status level.';
        }
        field(20; ExtremeFines; Decimal)
        {
            Caption = 'Extreme Status Fines';
            ToolTip = 'This field shows the what the fine for having an Book that is overdue on Extreme Status level.';
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