codeunit 50126 "Save Books"
{

 procedure save(Book: Record Library temporary)
    var
    Lib: Record Library;
    begin
      Lib.Init();
      Lib:= Book;
      Lib.Insert(true); 
    end;

}