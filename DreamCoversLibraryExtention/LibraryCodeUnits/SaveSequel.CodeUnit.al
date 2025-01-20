codeunit 50129 "Save Sequel"
{

    procedure SaveSequel(Sequel: Record Library temporary)//TODO Kan gemerge word met save book
    var
        recordNew, recordOld : Record Library;

    begin
        recordNew.Init();
        recordNew := Sequel;
        recordNew.Insert(true);

    end;
}