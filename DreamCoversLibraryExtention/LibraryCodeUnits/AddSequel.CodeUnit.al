codeunit 50128 SequelCode
{
     procedure Navigate_AddSequel(savedRec: Record Library)
    var
        tempRec: Record Library temporary;
        SaveSequel : Codeunit "Save Sequel";
    begin
        tempRec.Init();
        tempRec.Author := savedRec.Author;
        tempRec.Prequel := savedRec.Title;
        tempRec.Series := savedRec.Series;
        tempRec.Insert(true);
        if Page.RunModal(Page::"Sequel", TempRec) = Action::LookupOK then
        SaveSequel.SaveSequel(TempRec);
    end;

    var
        myInt: Integer;

}


