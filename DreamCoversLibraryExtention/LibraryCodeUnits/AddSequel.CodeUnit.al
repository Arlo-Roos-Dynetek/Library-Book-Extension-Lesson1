codeunit 50128 SequelCode
{
    procedure Navigate_AddSequel(savedRec: Record Library)
    var
        tempRec: Record Library temporary;
        SaveSequel: Codeunit "Save Sequel";
    begin
        tempRec.Init();
        tempRec.Validate(Author, savedRec.Author);
        tempRec.Validate(Prequel, savedRec.Title);
        tempRec.Validate(Series, savedRec.Series);

        //tempRec.Prequel := savedRec.Title;
        //tempRec.Series := savedRec.Series;
        tempRec.Insert(true);
        if Page.RunModal(Page::"Sequel", tempRec) = Action::LookupOK then begin
            savedRec.Validate(Sequel, tempRec.Title);
            savedRec.Modify(true);
            SaveSequel.SaveSequel(TempRec);
        end;

    end;
}


