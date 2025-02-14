/// <summary>
/// Codeunit Status Level Job Queue (ID 50310).
/// </summary>
/// This job queue updates the status of the books once a day.
codeunit 50310 "Status Level Job Queue"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        Library: Record Library;
    begin
        case rec."Parameter String" of
            'Update Once everyday':
                UpdateStatusEveryDay(Library)


            else
                if GuiAllowed then
                    Message('Something went wrong');
        end;
    end;

    local procedure UpdateStatusEveryDay(var Rec: Record Library)
    var
        RentFunctionality: Codeunit "Rent Functionality";
    begin
        if Rec.FindSet() then
        //Error('you broke your own code');
            repeat
                RentFunctionality.CalculateTimeOverdue(Rec);
                RentFunctionality.DetermineStatus(Rec);
                Rec.Modify(true);
            until Rec.Next() = 0;
        RentFunctionality.AssignCustomerLevel();

    end;

    var
        myInt: Integer;
}