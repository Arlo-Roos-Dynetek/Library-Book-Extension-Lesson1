codeunit 50123 "Rent Book"
{


    procedure ValdateRentInfo(MyLib: Record Library)
    begin
        if Page.RunModal(Page::"Rent Book", MyLib) = Action::LookupOK then
            if MyLib."Customer Name" <> '' then begin
                MyLib.Rented := true;
                MyLib.Modify(true);
            end
            else
                Message('Please enter a customer name.');
    end;
}