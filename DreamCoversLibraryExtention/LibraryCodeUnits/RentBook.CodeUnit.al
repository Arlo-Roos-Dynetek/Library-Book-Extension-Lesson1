codeunit 50123 "Rent Book"
{


    procedure ValidateRentInfo(MyLib: Record Library)
    var
    ErrorMessage: Text[100];
    begin
        ErrorMessage:= 'Please enter a customer name.';
        if Page.RunModal(Page::"Rent Book", MyLib) = Action::LookupOK then
            if MyLib."Customer Name" <> '' then begin
                MyLib.Rented := true;
                MyLib.Modify(true);
            end
            else
                Message(ErrorMessage);
    end;
}