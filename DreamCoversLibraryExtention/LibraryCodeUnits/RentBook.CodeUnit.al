/// <summary>
/// Codeunit Rent Book (ID 50123).
/// </summary>
codeunit 50123 "Rent Book"
{

    //this validates the rent field so that an already rented field is not rented out again.
    // if the user tries to rent a book that is already rented out it will display a error message telling the user that it is not possible to rent that book.
    // if the book is not rented , the books status will be changed to rented.

    /// <summary>
    /// ValidateRentInfo.
    /// </summary>
    /// <param name="MyLib">Record Library.</param>
    procedure ValidateRentInfo(MyLib: Record Library)
    var
        ErrorMessage: Text[100];
    begin
        ErrorMessage := 'Please Select a customer name.';
        if Page.RunModal(Page::"Rent Book", MyLib) = Action::LookupOK then
            if MyLib."Customer Name" <> '' then begin
                MyLib.Rented := true;
                MyLib."Amount Rented" := MyLib."Amount Rented" +1;
                MyLib.Modify(true);
            end
            else
                Message(ErrorMessage);
    end;
}