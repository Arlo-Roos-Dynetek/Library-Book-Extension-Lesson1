codeunit 50125 "Add books code"
{
    trigger OnRun()
    begin
        Navigate_add_book();
    end;
    local procedure Navigate_add_book() 
    var
    TempRec: Record Library temporary;
    SaveUnit : Codeunit "Save Books";
    begin
        TempRec.Init();
        TempRec.Insert(true);
    
        if Page.RunModal(Page::"Add Books", TempRec) = Action::LookupOK then
        SaveUnit.save(TempRec);
    end;
}