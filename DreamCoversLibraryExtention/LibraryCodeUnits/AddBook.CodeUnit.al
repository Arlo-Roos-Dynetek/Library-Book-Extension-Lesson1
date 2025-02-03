/// <summary>
/// Codeunit Add books code (ID 50125).
/// </summary>
codeunit 50125 "Add books code"
{
    // this code is used to add a book to the library table.
    trigger OnRun()
    begin
        Navigate_add_book();
    end;

    local procedure Navigate_add_book()
    var
        TempRec: Record Library temporary;
        SaveUnit: Codeunit "Library Functionality";
    begin
        TempRec.Init();
        TempRec.Insert(true);

        if Page.RunModal(Page::"Add Books", TempRec) = Action::LookupOK then
            SaveUnit.save(TempRec);
    end;
}