codeunit 50303 "Rent Functionality"
{
    //this validates the rent field so that an already rented field is not rented out again.
    // if the user tries to rent a book that is already rented out it will display a error message telling the user that it is not possible to rent that book.
    // if the book is not rented , the books status will be changed to rented.

    /// <summary>
    /// ValidateRentInfo.
    /// </summary>
    /// <param name="Library">Record Library.</param>
    procedure ValidateRentInfo(Library: Record Library)
    var
        ErrorMessage: Label 'Please Select a customer name.';
        WarningMessageMild: Label 'Please note that you have a book that is a week overdue';
        WarningMessageMedium: Label 'Please note that you have a book that is 2 weeks overdue and if the book is not Returned within the next 2 weeks the client will be fined!';
        WarningMessageHigh: Label 'Please note that you have a book that is a month overdue and have therefore been fined';
        WarningMessageExtreme: Label 'Please note that you have a book that is more than 2 months overdue and have therefore been fined Baned for 6 months.';
        WarningMessageNoMoreRenting: Label 'This customer is not allowed to rent a new book!';
        WarningMessageBaned: Label 'This customer has been baned, please check the "Library List Page" to see when the client will be allowed to rent a book again';
        Customer: Record Customer;
        DateFormula: DateFormula;
    begin

        // if Page.RunModal(Page::"Rent Book", Library) = Action::LookupOK then
        //     if (Library."Customer Name" <> '')  then begin
        //         //MyLib.Rented := true;
        //         //MyLib."Amount Rented" := MyLib."Amount Rented" +1;
        //         Library.Validate(Rented, true);
        //         Library.Validate("Amount Rented", +1);
        //         Library.Validate("Date Rented", Today);
        //         Library.Modify(true);
        //     end
        //     else
        //         Message(ErrorMessage);

        if Page.RunModal(Page::"Rent Book", Library) = Action::LookupOK then
            if (Library."Customer Name" = '') then begin
                exit;
                Message(ErrorMessage);
            end
            else begin
                Customer.Get(Library."Customer ID");
                case Customer.Status of
                    Customer.Status::Blank:
                        begin

                            if CalcDate('-6M', Today) > Customer."Probation Period" then
                                RentBook(Library, Customer);
                        end;

                    Customer.Status::Mild:
                        begin
                            RentBook(Library, Customer);

                            Message(WarningMessageMild);
                        end;
                    Customer.Status::Medium:
                        begin
                            Message(WarningMessageNoMoreRenting);
                            Message(WarningMessageMedium);
                            Library."Customer ID" := '';
                            Customer.Validate("Allow Rent", false);

                        end;
                    Customer.Status::High:
                        begin
                            Message(WarningMessageNoMoreRenting);
                            Message(WarningMessageHigh);
                            Library."Customer ID" := '';
                            Customer.Validate("Allow Rent", false);

                        end;
                    Customer.Status::Extreme:
                        begin
                            Message(WarningMessageNoMoreRenting);
                            Message(WarningMessageExtreme);
                            Library."Customer ID" := '';
                            Customer.Validate("Allow Rent", false);

                        end;
                    else
                end;
                Customer.Modify(true);
                Library.Modify(true);

            end;



    end;

    /// <summary>
    /// ReturnBook.
    /// </summary>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure is used to allow the user to return a book that they have rented. 
    procedure ReturnBook(var Library: Record Library)
    var
        ConfirmationMessage: Text;
        errorMessage: Label 'The book you are trying to return has already been returned';
        Customer: Record Customer;
        "Library table Setup": Record "Library table Setup";
        "Library Page Setup": Page "Library Page Setup";
        WarningMessageHigh: Label 'Please note that you have been fined for returning a book that is overdue for 1 month or more and have there for been fined. The fine can be ';
        WarningMessageExtreme: Label 'Please note that you have been fined for returning a book that is overdue for 2 months or more and have there for been fined and baned for 6 months. The fine can be ';
    begin
        ConfirmationMessage := Library.Title + ' has been returned';
        Customer.Get(Library."Customer ID");


        if Library.Rented = true then begin
            "Library table Setup".FindFirst();
            case Customer.Status of
                "Status Levels"::Blank:
                    begin
                        ChangedToReturned(Library);
                        Customer.Validate(Status, Customer.Status::Blank);
                        Library.Validate("Date Rented", 0D);


                        Message(ConfirmationMessage);
                    end;

                "Status Levels"::Mild:
                    begin
                        ChangedToReturned(Library);
                        Library.Validate(Status, Library.Status::Blank);
                        Customer.Validate(Status, Customer.Status::Blank);
                        Customer.Validate("Allow Rent", true);
                        Library.Validate("Date Rented", 0D);


                        Message(ConfirmationMessage);
                    end;
                "Status Levels"::Medium:
                    begin
                        ChangedToReturned(Library);
                        Library.Validate(Status, Library.Status::Blank);
                        Customer.Validate(Status, Customer.Status::Blank);
                        Customer.Validate("Allow Rent", true);
                        Library.Validate("Date Rented", 0D);


                        Message(ConfirmationMessage);
                    end;
                "Status Levels"::High:
                    begin
                        ChangedToReturned(Library);
                        Library.Validate(Status, Library.Status::Blank);
                        Customer.Validate(Status, Customer.Status::Blank);
                        Customer.Validate("Allow Rent", true);
                        Customer.Fines := Customer.Fines + "Library table Setup".Fines;
                        Library.Validate("Date Rented", 0D);

                        Message(WarningMessageHigh);
                        Message(ConfirmationMessage);
                    end;
                "Status Levels"::Extreme:
                    begin
                        ChangedToReturned(Library);
                        Library.Validate(Status, Library.Status::Blank);
                        Customer.Validate("Allow Rent", false);
                        Customer.Fines := Customer.Fines + "Library table Setup".Fines;
                        Customer.Validate("Probation Period", CalcDate('+6M', Today));
                        // Customer.Validate(Status, Customer.Status::Blank);
                        Library.Validate("Date Rented", 0D);
                        Message(WarningMessageExtreme);
                        Message(ConfirmationMessage);
                    end;

                else
                    Message(errorMessage);
            end;
            Library.Modify(true);
            Customer.Modify(true);
        end
        else
            Message(errorMessage);
        // if Library.Rented = true then begin
        //     Library."Customer Name" := '';
        //     Library.Validate("Customer ID", ' ');
        //     Library.Validate(Rented, false);
        //     Library.Validate("Date Returned", Today);
        //     Library.Modify(true);
        //     Message(ConfirmationMessage);
        // end
        // else
        //     Message(errorMessage);
    end;


    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertLibrary(var Rec: Record Library)
    begin
        CalculateTimeOverdue(Rec);
        DetermineStatus(Rec);
        //  AssignCustomerLevel(/*Rec*/);
    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyLibrary(var Rec: Record Library)
    begin
        CalculateTimeOverdue(Rec);
        DetermineStatus(Rec);
        // AssignCustomerLevel(/*Rec*/);
    end;

    [EventSubscriber(ObjectType::Page, Page::"List Of Books", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageBookList(var Rec: Record Library)
    begin
        if Rec.FindSet() then
            repeat
                CalculateTimeOverdue(Rec);
                DetermineStatus(Rec);
                Rec.Modify(true);
            until Rec.Next() = 0;
        AssignCustomerLevel(/*Rec*/);

    end;

    procedure AssignCustomerLevel()
    var
        Library: Record Library;
        Customer: Record Customer;
    begin
        Library.SetFilter(Rented, 'true');
        if Library.FindSet() then
            repeat
                Customer.Get(Library."Customer ID");
                Customer.Validate(Status, Library.Status);

                if Customer."Status".AsInteger() > Customer."Highest Status".AsInteger() then
                    Customer.Validate("Highest Status", Customer.Status);
                Customer.Modify(true)
            until Library.Next() = 0;

    end;



    local procedure DetermineStatus(var Library: Record Library)
    var
        Customer: Record Customer;
    begin
        case Library."Weeks Overdue" of
            0:
                Library.Validate(Status, Library.Status::Blank);
            1:
                Library.Validate(Status, Library.Status::Mild);
            2 .. 3:
                Library.Validate(Status, Library.Status::Medium);
            4:
                Library.Validate(Status, Library.Status::High);

            else
                Library.Validate(Status, Library.Status::Extreme);
        end;
    end;



    local procedure CalculateTimeOverdue(var Library: Record Library)
    begin
        if Library."Date Rented" = 0D then
            exit;

        library.Validate("Weeks Overdue", Round((Today - Library."Date Rented") / 7, 1, '='));
    end;

    local procedure RentBook(var Library: Record Library; var Customer: Record Customer)
    var
        NotAbleToRent: Label 'Sorry, you are not able to rent this book.';
    // Customer: Record Customer;
    begin
        // Customer.Get(Library."Customer ID");
        if (Customer.Status.AsInteger() = 40) or (Customer.Status.AsInteger() = 30) or (Customer.Status.AsInteger() = 20) then begin
            Message(NotAbleToRent);
            exit;
        end
        else
            if (CalcDate('-6M', Today) > Customer."Probation Period") or (Customer."Allow Rent" <> true) then begin
                Customer.Validate("Allow Rent", true);
                Library.Validate(Rented, true);
                Library.Validate("Amount Rented", +1);
                Library.Validate("Date Rented", Today);
                Library.Modify(true);
                Customer.Modify(true);
            end;
        // if Library."Allow Rent" <> true then begin
        //     Message(NotAbleToRent);
        //     exit;
        // end

        // else begin
        //     Library.Validate(Rented, true);
        //     Library.Validate("Amount Rented", +1);
        //     Library.Validate("Date Rented", Today);
        //     Library.Modify(true);
        // end;

    end;

    local procedure ChangedToReturned(var Library: Record Library)
    begin
        Library."Customer Name" := '';
        Library.Validate("Customer ID", ' ');
        Library.Validate(Rented, false);
        Library.Validate("Date Returned", Today);


    end;





    procedure ShowAllOverdueBooks(var Library: Record Library)
    begin
        Library.SetFilter("Weeks Overdue", '>0');
    end;
    // procedure DetermineStatus()
    // var
    //     Library: Record Library;
    //     TimeBetweenDates: Integer;
    // begin
    //     repeat begin
    //         Library.SetCurrentKey("Book ID");
    //         Library.SetFilter(Rented, 'true');
    //         library.FindFirst();
    //         TimeBetweenDates := today - Library."Date Rented";

    //         case TimeBetweenDates of
    //             0 .. 6:
    //                 begin
    //                     Library.Status := '';
    //                 end;
    //             7 .. 13:
    //                 begin
    //                     Library.Status := 'Mild';
    //                 end;
    //             14 .. 27:
    //                 begin
    //                     Library.Status := 'Medium';
    //                 end;
    //             28 .. 55:
    //                 begin
    //                     Library.Status := 'High';
    //                 end;
    //             56:
    //                 begin
    //                     Library.Status := 'Extreme';
    //                 end;

    //             else
    //                 Library.Status := 'Extreme';

    //         end;
    //         Library.Modify(true)
    //     end until Library.Next() = 0;
    // end;
    // procedure CalculateStatus()
    // var
    //     LibraryRec: Record Library;
    //     Customer: Record Customer;
    //     TimeBetweenRentedAndReturned: Integer;
    //     "Status Levels2": Enum "Status Levels";
    //     myInteger: Integer;
    // begin

    //     //LibraryRec.LoadFields("Date Rented", Status, "Customer ID", Rented);
    //     // Message(Format(Today - LibraryRec."Date Rented"));

    //     LibraryRec.SetFilter("Rented", 'true');
    //     LibraryRec.SetFilter("Date Rented", '<>%1', 0D);
    //     if LibraryRec.FindSet() then
    //         repeat begin
    //             if Customer.get(LibraryRec."Customer ID") then begin
    //                 TimeBetweenRentedAndReturned := (Today - LibraryRec."Date Rented");
    //                 case TimeBetweenRentedAndReturned of
    //                     0 .. 6:
    //                         begin

    //                             Customer.Status := ' ';
    //                             LibraryRec.Status := '';

    //                         end;

    //                     7 .. 13:
    //                         begin

    //                             Customer.Status := 'Mild';
    //                             LibraryRec.Status := 'Mild';

    //                         end;


    //                     14 .. 27:
    //                         begin

    //                             Customer.Status := 'Medium';
    //                             LibraryRec.Status := 'Medium';

    //                         end;


    //                     28 .. 55:
    //                         begin


    //                             Customer.Status := 'High';
    //                             LibraryRec.Status := 'High';


    //                         end;

    //                     56:
    //                         begin

    //                             Customer.Status := 'Extreme';

    //                         end;


    //                     else begin

    //                         Customer.Status := 'Extreme';

    //                     end;

    //                 end;
    //                 Customer.Modify(true);
    //                 LibraryRec.Modify(true);
    //             end;
    //             myInteger := LibraryRec.Next();
    //             Message(Customer.Name)
    //         end until myInteger = 0;
    // end;

}