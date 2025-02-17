/// <summary>
/// Codeunit Rent Functionality (ID 50303).
/// </summary>
codeunit 50303 "Rent Functionality"
{
    //this validates the rent field so that an already rented field is not rented out again.
    // if the user tries to rent a book that is already rented out it will display a error message telling the user that it is not possible to rent that book.
    // if the book is not rented , the books status will be changed to rented.
    // This code unit now also saves rented and returned data to a log page.


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
        DateProbationEnd: Integer;
        ExceededMildCounter: Label 'You have exceeded your renting limit of 3 books with your Mild Status';

    begin


        if Page.RunModal(Page::"Rent Book", Library) = Action::LookupOK then
            if (Library."Customer Name" = '') then begin
                exit;


            end
            else begin

                Customer.Get(Library."Customer ID");

                case Customer.Status of
                    Customer.Status::Blank:
                        begin

                            if CalcDate('<-6M>', Today) > Customer."Probation Period" then
                                RentBook(Library, Customer);
                        end;

                    Customer.Status::Mild:
                        begin

                            if Customer."Mild Counter" < 3 then
                                RentBook(Library, Customer)
                            else
                                Message(ExceededMildCounter);

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
                            Message(WarningMessageNoMoreRenting + '///' + WarningMessageExtreme);
                            DateProbationEnd := Today - Customer."Probation Period";
                            Message('This is the amount of days remaining on your probation period: ' + Format(DateProbationEnd));
                            Library."Customer ID" := '';
                            Customer.Validate("Allow Rent", false);

                        end;
                    else
                        exit;
                end;
                Customer.Modify(true);
                Library.Modify(true);

            end;
    end;

    local procedure LogBookInfo(var Library: Record Library)
    var
        BookLogTable: Record "Book Log Table";

    begin
        BookLogTable.Init();
        if library.Rented then begin
            BookLogTable.Validate(Action, 'Rented');
            BookLogTable.Validate("Date Rented", Today);
            BookLogTable.Validate("Date Returned", 0D);
        end
        else begin
            BookLogTable.Validate(Action, 'Returned');
            BookLogTable.Validate("Date Returned", Today);
            BookLogTable.Validate("Date Rented", Library."Date Rented");
        end;


        if (Library."Date Returned" <> 0D) and (Library."Date Rented" <> 0D) then
            BookLogTable.Validate("Rent Duration", Library."Date Returned" - Library."Date Rented");
        // else
        //     BookLogTable.Validate("Rent Duration", 0);

        BookLogTable.Validate("Book Title", Library.Title);
        BookLogTable.Validate("Customer Name", Library."Customer Name");
        BookLogTable.Insert(true);
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
        LibraryTableSetup: Record "Library table Setup";
        LibraryPageSetup: Page "Library Page Setup";
        WarningMessageHigh: Label 'Please note that you have been fined for returning a book that is overdue for 1 month or more and have there for been fined. The fine can be ';
        WarningMessageExtreme: Label 'Please note that you have been fined for returning a book that is overdue for 2 months or more and have there for been fined and baned for 6 months. The fine can be found on the Customers card page.';

    begin

        if Library.Rented = false then begin
            Message(errorMessage);
            exit;
        end;

        ConfirmationMessage := Library.Title + ' has been returned';
        Customer.Get(Library."Customer ID");

        LibraryTableSetup.Get();

        case Customer.Status of
            "Status Levels"::Blank:
                begin

                    ChangedToReturned(Library);
                    Library.Validate(Status, Library.Status::Blank);
                    Library.Modify(true); // yes this is necessary!!!!!!!!!!!!
                    AssignNewStatusLevel(Library, Customer);
                    Library.Validate("Date Rented", 0D);
                    Library."Customer Name" := '';

                    Message(ConfirmationMessage);
                end;

            "Status Levels"::Mild:
                begin
                    Library.Validate(Status, Library.Status::Blank);
                    ReturnAssignment(Library, Customer);
                    Customer.Validate("Mild Counter", 0);
                    Library.Modify(true); // yes this is necessary!!!!!!!!!!!!
                    AssignNewStatusLevel(Library, Customer);
                    Library."Customer Name" := '';
                    Message(ConfirmationMessage);
                end;
            "Status Levels"::Medium:
                begin
                    Library.Validate(Status, Library.Status::Blank);
                    ReturnAssignment(Library, Customer);
                    Library.Modify(true); // yes this is necessary!!!!!!!!!!!!
                    AssignNewStatusLevel(Library, Customer);
                    Library."Customer Name" := '';

                    Message(ConfirmationMessage);
                end;
            "Status Levels"::High:
                begin
                    Library.Validate(Status, Library.Status::Blank);
                    ReturnAssignment(Library, Customer);
                    Customer.Fines := Customer.Fines + LibraryTableSetup.HighFines;
                    Library.Modify(true); // yes this is necessary!!!!!!!!!!!!
                    AssignNewStatusLevel(Library, Customer);
                    Library."Customer Name" := '';
                    Message(WarningMessageHigh);
                    Message(ConfirmationMessage);
                end;
            "Status Levels"::Extreme:
                begin
                    ChangedToReturned(Library);
                    Library.Validate(Status, Library.Status::Blank);
                    Customer.Validate("Allow Rent", false);
                    Customer.Fines := Customer.Fines + LibraryTableSetup.ExtremeFines;
                    Customer.Validate("Probation Period", CalcDate('+6M', Today));
                    Library.Modify(true); // yes this is necessary!!!!!!!!!!!!
                    AssignNewStatusLevel(Library, Customer);
                    Library."Customer Name" := '';
                    Library.Validate("Date Rented", 0D);
                    Message(WarningMessageExtreme + '\\\' + ConfirmationMessage);

                end;

            else begin
                Message(errorMessage);
                exit;
            end;

        end;
        Library.Modify(true);
        Customer.Modify(true);



    end;


    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertLibrary(var Rec: Record Library)
    begin
        CalculateTimeOverdue(Rec);
        DetermineStatus(Rec);

    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyLibrary(var Rec: Record Library)
    begin
        CalculateTimeOverdue(Rec);
        DetermineStatus(Rec);

    end;

    // [EventSubscriber(ObjectType::Page, Page::"List Of Books", 'OnOpenPageEvent', '', false, false)]
    // local procedure OnOpenPageBookList(var Rec: Record Library)
    // begin
    //     if Rec.FindSet() then
    //         repeat
    //             CalculateTimeOverdue(Rec);
    //             DetermineStatus(Rec);
    //             Rec.Modify(true);
    //         until Rec.Next() = 0;
    //     AssignCustomerLevel();

    // end;

    /// <summary>
    /// AssignCustomerLevel.
    /// </summary>
    procedure AssignCustomerLevel()
    var
        Library: Record Library;
        Customer: Record Customer;
    begin
        Library.SetFilter(Rented, 'true');
        if Library.FindSet() then
            repeat
                Customer.Get(Library."Customer ID");
                if Library.Status.AsInteger() > Customer.Status.AsInteger() then
                    Customer.Validate(Status, Library.Status);

                if Customer."Status".AsInteger() > Customer."Highest Status".AsInteger() then
                    Customer.Validate("Highest Status", Customer.Status);
                Customer.Modify(true)
            until Library.Next() = 0;

    end;
    /// <summary>
    /// DetermineStatus.
    /// </summary>
    /// <param name="Library">VAR Record Library.</param>
    procedure DetermineStatus(var Library: Record Library)
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
    /// <summary>
    /// CalculateTimeOverdue.
    /// </summary>
    /// <param name="Library">VAR Record Library.</param>
    procedure CalculateTimeOverdue(var Library: Record Library)
    begin
        if Library."Date Rented" = 0D then begin
            library.Validate("Weeks Overdue", 0);
            exit;
        end;

        library.Validate("Weeks Overdue", Round((Today - Library."Date Rented") / 7, 1, '='));
    end;

    local procedure RentBook(var Library: Record Library; var Customer: Record Customer)
    var
        NotAbleToRent: Label 'Sorry, you are not able to rent this book.';

    begin

        if (Customer.Status = Customer.Status::Extreme) or (Customer.Status = Customer.Status::High) or (Customer.Status = Customer.Status::Medium) then begin
            Message(NotAbleToRent);
            exit;
        end;


        if (Today < Customer."Probation Period") or (not Customer."Allow Rent") then
            exit;

        Library.Validate(Rented, true);
        LogBookInfo(Library);
        Library."Amount Rented" := Library."Amount Rented" + 1;
        Library.Validate("Date Rented", Today);
        Customer."Mild Counter" := Customer."Mild Counter" + 1;
        Library.Modify(true);
        Customer.Modify(true);

    end;


    local procedure ChangedToReturned(var Library: Record Library)
    var
        BookLogTable: Record "Book Log Table";
    begin
        Library.Validate(Rented, false);
        LogBookInfo(Library);
        Library.Validate("Customer ID", ' ');
        Library.Validate("Date Returned", Today);
    end;

    local procedure ReturnAssignment(var Library: Record Library; var Customer: Record Customer)
    begin
        ChangedToReturned(Library);
        Customer.Validate("Allow Rent", true);
        Library.Validate("Date Rented", 0D);
    end;

    local procedure AssignNewStatusLevel(var Library: Record Library; var Customer: Record Customer)
    var
        Library2: Record Library;
    begin
        Library2.SetFilter(Rented, 'true');
        library2.SetFilter("Customer Name", Library."Customer Name");
        Customer.Validate(Status, Enum::"Status Levels"::Blank);

        if Library2.FindSet() then
            repeat
                if Library2.Status.AsInteger() > Customer.Status.AsInteger() then
                    Customer.Validate(Status, Library2.Status);
            until Library2.Next() = 0;
    end;

    /// <summary>
    /// ShowAllOverdueBooks.
    /// </summary>
    /// <param name="Library">VAR Record Library.</param>
    procedure ShowAllOverdueBooks(var Library: Record Library)
    begin
        Library.SetFilter("Weeks Overdue", '>0');
    end;
}