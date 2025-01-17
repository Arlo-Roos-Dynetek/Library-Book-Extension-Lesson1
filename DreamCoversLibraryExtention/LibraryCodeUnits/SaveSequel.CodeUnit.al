codeunit 50129 "Save Sequel"
{

procedure SaveSequel(Sequel: Record Library temporary/*; Prequel: Record Library temporary*/)
    var
      recordNew, recordOld: Record Library;
      
    begin
        recordNew.Init();
        recordNew:= Sequel;
        recordNew.Insert(true);
       
    end;
}