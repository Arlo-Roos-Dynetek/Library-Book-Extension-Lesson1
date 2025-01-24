codeunit 50130 "Return Book"
{
    procedure ReturnBook(var Library: Record Library)
    var
        ConfirmationMessage, errorMessage : Text;
    begin
        ConfirmationMessage := Library.Title + ' has been returned';
        errorMessage := 'The book you are trying to return has already been returned';

        if Library.Rented = true then begin
            Library."Customer ID" := '';
            Library."Customer Name" := '';
            Library.Rented := false;
            Library.Modify(true);
            Message(ConfirmationMessage);
        end
        else
            Message(errorMessage);


    end;

    var
        myInt: Integer;
}