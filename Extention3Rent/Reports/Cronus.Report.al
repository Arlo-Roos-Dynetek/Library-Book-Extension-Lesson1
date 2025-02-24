namespace Microsoft.Purchases.Document;

using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Utilities;
report 50301 CronusReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Reports/Report Layouts/LayoutName.docx';



    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column("Order_No"; "No.")
            {

            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {
            }
            column(BuyFromAddr6; BuyFromAddr[6])
            {
            }
            column(BuyFromAddr7; BuyFromAddr[7])
            {
            }
            column(BuyFromAddr8; BuyFromAddr[8])
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(DocumentTitle_lbl; DocumentTitle_Lbl)
            {
            }
            column(Page_Lbl; Page_Lbl)
            {
            }
            column(VATRegistrationNo_Lbl; VATRegistrationNo_Lbl)
            {
            }
            column(ARcdNotInvExVATLCY_DataItemName; "A. Rcd. Not Inv. Ex. VAT (LCY)")
            {
            }
            column(Amount_DataItemName; Amount)
            {
            }
            column(AmountIncludingVAT_DataItemName; "Amount Including VAT")
            {
            }
            column(AmtRcdNotInvoicedLCY_DataItemName; "Amt. Rcd. Not Invoiced (LCY)")
            {
            }

            column(BuyfromAddress_DataItemName; "Buy-from Address")
            {
            }
            column(BuyfromAddress2_DataItemName; "Buy-from Address 2")
            {
            }
            column(BuyfromCity_DataItemName; "Buy-from City")
            {
            }
            column(BuyfromContact_DataItemName; "Buy-from Contact")
            {
            }
            column(BuyfromContactNo_DataItemName; "Buy-from Contact No.")
            {
            }
            column(BuyfromCountryRegionCode_DataItemName; "Buy-from Country/Region Code")
            {
            }
            column(BuyfromCounty_DataItemName; "Buy-from County")
            {
            }
            column(BuyfromICPartnerCode_DataItemName; "Buy-from IC Partner Code")
            {
            }
            column(BuyfromPostCode_DataItemName; "Buy-from Post Code")
            {
            }
            column(BuyfromVendorName_DataItemName; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2_DataItemName; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromVendorNo_DataItemName; "Buy-from Vendor No.")
            {
            }
            column(CampaignNo_DataItemName; "Campaign No.")
            {
            }
            column(DocumentDate_DataItemName; Format("Document Date", 0, 4))
            {

            }
            column(DocumentType_DataItemName; "Document Type")
            {
            }
            column(DueDate_DataItemName; "Due Date")
            {
            }

            column(LocationCode_DataItemName; "Location Code")
            {
            }
            column(No_DataItemName; "No.")
            {
            }
            column(OrderAddressCode_DataItemName; "Order Address Code")
            {
            }
            column(OrderClass_DataItemName; "Order Class")
            {
            }
            column(OrderDate_DataItemName; "Order Date")
            {
            }
            column(PartiallyInvoiced_DataItemName; "Partially Invoiced")
            {
            }
            column(PaytoAddress_DataItemName; "Pay-to Address")
            {
            }
            column(PaytoAddress2_DataItemName; "Pay-to Address 2")
            {
            }
            column(PaytoCity_DataItemName; "Pay-to City")
            {
            }
            column(PaytoContact_DataItemName; "Pay-to Contact")
            {
            }
            column(PaytoContactNo_DataItemName; "Pay-to Contact No.")
            {
            }
            column(PaytoCountryRegionCode_DataItemName; "Pay-to Country/Region Code")
            {
            }
            column(PaytoCounty_DataItemName; "Pay-to County")
            {
            }
            column(PaytoICPartnerCode_DataItemName; "Pay-to IC Partner Code")
            {
            }
            column(PaytoName_DataItemName; "Pay-to Name")
            {
            }
            column(PaytoName2_DataItemName; "Pay-to Name 2")
            {
            }
            column(PaytoPostCode_DataItemName; "Pay-to Post Code")
            {
            }
            column(PaytoVendorNo_DataItemName; "Pay-to Vendor No.")
            {
            }
            column(PaymentDiscount_DataItemName; "Payment Discount %")
            {
            }
            column(PaymentMethodCode_DataItemName; "Payment Method Code")
            {
            }
            column(PaymentReference_DataItemName; "Payment Reference")
            {
            }
            column(PaymentTermsCode_DataItemName; "Payment Terms Code")
            {
            }

            column(PendingApprovals_DataItemName; "Pending Approvals")
            {
            }
            column(PmtDiscountDate_DataItemName; "Pmt. Discount Date")
            {
            }
            column(PostingDate_DataItemName; "Posting Date")
            {
            }
            column(PostingDescription_DataItemName; "Posting Description")
            {
            }
            column(PostingfromWhseRef_DataItemName; "Posting from Whse. Ref.")
            {
            }
            column(PostingNo_DataItemName; "Posting No.")
            {
            }
            column(PostingNoSeries_DataItemName; "Posting No. Series")
            {
            }
            column(Prepayment_DataItemName; "Prepayment %")
            {
            }
            column(PrepaymentDueDate_DataItemName; "Prepayment Due Date")
            {
            }
            column(PrepaymentNo_DataItemName; "Prepayment No.")
            {
            }
            column(PrepaymentNoSeries_DataItemName; "Prepayment No. Series")
            {
            }
            column(PrepmtCrMemoNo_DataItemName; "Prepmt. Cr. Memo No.")
            {
            }
            column(PrepmtCrMemoNoSeries_DataItemName; "Prepmt. Cr. Memo No. Series")
            {
            }
            column(PrepmtPaymentDiscount_DataItemName; "Prepmt. Payment Discount %")
            {
            }
            column(PrepmtPaymentTermsCode_DataItemName; "Prepmt. Payment Terms Code")
            {
            }
            column(PrepmtPmtDiscountDate_DataItemName; "Prepmt. Pmt. Discount Date")
            {
            }
            column(PrepmtPostingDescription_DataItemName; "Prepmt. Posting Description")
            {
            }
            column(PriceCalculationMethod_DataItemName; "Price Calculation Method")
            {
            }
            column(PricesIncludingVAT_DataItemName; "Prices Including VAT")
            {
            }
            column(PrintPostedDocuments_DataItemName; "Print Posted Documents")
            {
            }
            column(PromisedReceiptDate_DataItemName; "Promised Receipt Date")
            {
            }
            column(PurchaserCode_DataItemName; "Purchaser Code")
            {
            }
            column(QuoteNo_DataItemName; "Quote No.")
            {
            }
            column(ReasonCode_DataItemName; "Reason Code")
            {
            }
            column(RecalculateInvoiceDisc_DataItemName; "Recalculate Invoice Disc.")
            {
            }
            column(Receive_DataItemName; Receive)
            {
            }
            column(ReceivedNotInvoiced_DataItemName; "Received Not Invoiced")
            {
            }
            column(ReceivingNo_DataItemName; "Receiving No.")
            {
            }
            column(ReceivingNoSeries_DataItemName; "Receiving No. Series")
            {
            }
            column(RemittoCode_DataItemName; "Remit-to Code")
            {
            }
            column(RequestedReceiptDate_DataItemName; "Requested Receipt Date")
            {
            }
            column(ResponsibilityCenter_DataItemName; "Responsibility Center")
            {
            }
            column(ReturnShipmentNo_DataItemName; "Return Shipment No.")
            {
            }
            column(ReturnShipmentNoSeries_DataItemName; "Return Shipment No. Series")
            {
            }
            column(SelltoCustomerNo_DataItemName; "Sell-to Customer No.")
            {
            }
            column(SendICDocument_DataItemName; "Send IC Document")
            {
            }
            column(Ship_DataItemName; Ship)
            {
            }
            column(ShiptoAddress_DataItemName; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_DataItemName; "Ship-to Address 2")
            {
            }
            column(ShiptoCity_DataItemName; "Ship-to City")
            {
            }
            column(ShiptoCode_DataItemName; "Ship-to Code")
            {
            }
            column(ShiptoContact_DataItemName; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode_DataItemName; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty_DataItemName; "Ship-to County")
            {
            }
            column(ShiptoName_DataItemName; "Ship-to Name")
            {
            }
            column(ShiptoName2_DataItemName; "Ship-to Name 2")
            {
            }
            column(ShiptoPhoneNo_DataItemName; "Ship-to Phone No.")
            {
            }
            column(ShiptoPostCode_DataItemName; "Ship-to Post Code")
            {
            }
            column(ShipmentMethodCode_DataItemName; "Shipment Method Code")
            {
            }

            column(ShortcutDimension1Code_DataItemName; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_DataItemName; "Shortcut Dimension 2 Code")
            {
            }
            column(Status_DataItemName; Status)
            {
            }
            column(SystemCreatedAt_DataItemName; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy_DataItemName; SystemCreatedBy)
            {
            }
            column(SystemId_DataItemName; SystemId)
            {
            }
            column(SystemModifiedAt_DataItemName; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy_DataItemName; SystemModifiedBy)
            {
            }
            column(TaxAreaCode_DataItemName; "Tax Area Code")
            {
            }
            column(TaxLiable_DataItemName; "Tax Liable")
            {
            }
            column(TransactionSpecification_DataItemName; "Transaction Specification")
            {
            }
            column(TransactionType_DataItemName; "Transaction Type")
            {
            }
            column(TransportMethod_DataItemName; "Transport Method")
            {
            }
            column(VATBaseDiscount_DataItemName; "VAT Base Discount %")
            {
            }
            column(VATBusPostingGroup_DataItemName; "VAT Bus. Posting Group")
            {
            }
            column(VATCountryRegionCode_DataItemName; "VAT Country/Region Code")
            {
            }
            column(VATRegistrationNo_DataItemName; "VAT Registration No.")
            {
            }
            column(VATReportingDate_DataItemName; "VAT Reporting Date")
            {
            }
            column(VendorAuthorizationNo_DataItemName; "Vendor Authorization No.")
            {
            }
            column(VendorCrMemoNo_DataItemName; "Vendor Cr. Memo No.")
            {
            }
            column(VendorInvoiceNo_DataItemName; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_DataItemName; "Vendor Order No.")
            {
            }
            column(VendorPostingGroup_DataItemName; "Vendor Posting Group")
            {
            }
            column(VendorShipmentNo_DataItemName; "Vendor Shipment No.")
            {
            }
            column(YourReference_DataItemName; "Your Reference")
            {


            }
            column(TotalExcVAT; TotalExcVAT)
            {

            }
            column(TotalIncVAT; TotalIncVAT)
            {

            }
            column(VATAmount; VATAmount)
            {

            }
            dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {
                DataItemLink = "Code" = field("Purchaser Code");
                column(PurchaserName; Name)
                {

                }

            }
            dataitem("Shipment Method"; "Shipment Method")
            {
                DataItemLink = "Code" = field("Shipment Method Code");
                column(Shipment_Method_Description; Description)
                { }
            }
            dataitem("Payment Terms Code"; "Payment Terms")
            {
                DataItemLink = "Code" = field("Payment Terms Code");
                column("Payment_Description"; Description)
                { }
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_Purchaseline; "No.") { }

                column(No_PurchLine_Lbl; No_PurchLine_Lbl)
                {
                }
                column(Desc_PurchLine_Lbl; Desc_PurchLine_Lbl)
                {
                }
                column(Qty_PurchLine_Lbl; Qty_PurchLine_Lbl)
                {
                }
                column(UOM_PurchLine_Lbl; UOM_PurchLine_Lbl)
                {
                }
                column(DirectUniCost_Lbl; DirectUniCost_Lbl)
                {
                }
                column(VATAmtLineVAT_Lbl; VATAmtLineVAT_Lbl)
                {
                }
                column(ItemLineAmount_Lbl; ItemLineAmount_Lbl)
                {
                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(VAT__; "VAT %")
                {

                }
                column(VATAmount_Lbl; VATAmount_Lbl)
                {

                }
                column(TotalIncVAT_Lbl; TotalIncVAT_Lbl)
                {

                }
                column(TotalExcVAT_Lbl; TotalExcVAT_Lbl)
                {

                }

                column(Line_Amount; "Line Amount")
                {

                }

            }
            dataitem("Company Information"; "Company Information")
            {

                column(ShiptoAddress_Lbl; ShiptoAddress_Lbl)
                {

                }
                column(PaymentTermsDesc_Lbl; PaymentTermsDesc_Lbl)
                {

                }
                column(Buyer_Lbl; Buyer_Lbl)
                {

                }


                column(Receiveby_Lbl; Receiveby_Lbl)
                {

                }
                column(ShipmentMethodDesc_Lbl; ShipmentMethodDesc_Lbl)
                {

                }
                column(PricesInclVAT_PurchHeader_Lbl; PricesInclVAT_PurchHeader_Lbl)
                {

                }
                column(CompanyVATRegistrationNo_Lbl; CompanyVATRegistrationNo_Lbl)
                {

                }
                column(VAT_Registration_No_; "VAT Registration No.")
                {

                }
                column(CompanyGiroNo_Lbl; CompanyGiroNo_Lbl)
                {

                }
                column(VendorInvoiceNo_Lbl; VendorInvoiceNo_Lbl)
                {

                }
                column(VendorOrderNo_Lbl; VendorOrderNo_Lbl)
                {

                }
                column(Address; Address)
                {

                }
                column(Address_2; "Address 2")
                {

                }
                column(Ship_to_Address; "Ship-to Address")
                {

                }
                column(AllowBlankPaymentInfo_CompanyInformation; "Allow Blank Payment Info.")
                {
                }
                column(AlternativeLanguageCode_CompanyInformation; "Alternative Language Code")
                {
                }
                column(BankAccountNo_CompanyInformation; "Bank Account No.")
                {
                }
                column(BankBranchNo_CompanyInformation; "Bank Branch No.")
                {
                }
                column(BankName_CompanyInformation; "Bank Name")
                {
                }
                column(BrandColorValue_CompanyInformation; "Brand Color Value")
                {
                }
                column(CalConvergenceTimeFrame_CompanyInformation; "Cal. Convergence Time Frame")
                {
                }
                column(CheckAvailPeriodCalc_CompanyInformation; "Check-Avail. Period Calc.")
                {
                }
                column(CheckAvailTimeBucket_CompanyInformation; "Check-Avail. Time Bucket")
                {
                }
                column(City_CompanyInformation; City)
                {
                }
                column(ContactPerson_CompanyInformation; "Contact Person")
                {
                }
                column(CountryRegionCode_CompanyInformation; "Country/Region Code")
                {
                }
                column(County_CompanyInformation; County)
                {
                }
                column(CreatedDateTime_CompanyInformation; "Created DateTime")
                {
                }
                column(CustomSystemIndicatorText_CompanyInformation; "Custom System Indicator Text")
                {
                }
                column(CustomsPermitDate_CompanyInformation; "Customs Permit Date")
                {
                }
                column(CustomsPermitNo_CompanyInformation; "Customs Permit No.")
                {
                }
                column(DemoCompany_CompanyInformation; "Demo Company")
                {
                }
                column(EMail_CompanyInformation; "E-Mail")
                {
                }
                column(EORINumber_CompanyInformation; "EORI Number")
                {
                }
                column(FaxNo_CompanyInformation; "Fax No.")
                {
                }
                column(GiroNo_CompanyInformation; "Giro No.")
                {
                }
                column(GLN_CompanyInformation; GLN)
                {
                }
                column(IBAN_CompanyInformation; IBAN)
                {
                }
                column(IndustrialClassification_CompanyInformation; "Industrial Classification")
                {
                }
                column(LastModifiedDateTime_CompanyInformation; "Last Modified Date Time")
                {
                }
                column(LocationCode_CompanyInformation; "Location Code")
                {
                }
                column(Name_CompanyInformation; Name)
                {
                }
                column(Name2_CompanyInformation; "Name 2")
                {
                }
                column(PaymentRoutingNo_CompanyInformation; "Payment Routing No.")
                {
                }
                column(PhoneNo_CompanyInformation; "Phone No.")
                {
                }
                column(PhoneNo2_CompanyInformation; "Phone No. 2")
                {
                }
                column(Picture_CompanyInformation; Picture)
                {
                }
                column(PictureLastModDateTime_CompanyInformation; "Picture - Last Mod. Date Time")
                {
                }
                column(PostCode_CompanyInformation; "Post Code")
                {
                }
                column(PrimaryKey_CompanyInformation; "Primary Key")
                {
                }
                column(RegistrationNo_CompanyInformation; "Registration No.")
                {
                }
                column(ResponsibilityCenter_CompanyInformation; "Responsibility Center")
                {
                }
                column(ShiptoAddress2_CompanyInformation; "Ship-to Address 2")
                {
                }
                column(ShiptoCity_CompanyInformation; "Ship-to City")
                {
                }
                column(ShiptoContact_CompanyInformation; "Ship-to Contact")
                {
                }
                column(ShiptoCountryRegionCode_CompanyInformation; "Ship-to Country/Region Code")
                {
                }
                column(ShiptoCounty_CompanyInformation; "Ship-to County")
                {
                }
                column(ShiptoName_CompanyInformation; "Ship-to Name")
                {
                }
                column(ShiptoName2_CompanyInformation; "Ship-to Name 2")
                {
                }
                column(ShiptoPhoneNo_CompanyInformation; "Ship-to Phone No.")
                {
                }
                column(ShiptoPostCode_CompanyInformation; "Ship-to Post Code")
                {
                }
                column(SWIFTCode_CompanyInformation; "SWIFT Code")
                {
                }
                column(SystemIndicator_CompanyInformation; "System Indicator")
                {
                }
                column(SystemIndicatorStyle_CompanyInformation; "System Indicator Style")
                {
                }
                column(SystemCreatedAt_CompanyInformation; SystemCreatedAt)
                {
                }
                column(SystemCreatedBy_CompanyInformation; SystemCreatedBy)
                {
                }
                column(SystemId_CompanyInformation; SystemId)
                {
                }
                column(SystemModifiedAt_CompanyInformation; SystemModifiedAt)
                {
                }
                column(SystemModifiedBy_CompanyInformation; SystemModifiedBy)
                {
                }
                column(TelexAnswerBack_CompanyInformation; "Telex Answer Back")
                {
                }
                column(TelexNo_CompanyInformation; "Telex No.")
                {
                }
                column(UseGLNinElectronicDocument_CompanyInformation; "Use GLN in Electronic Document")
                {
                }
                column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                {
                }
                dataitem("Country/Region"; "Country/Region")
                {
                    DataItemLink = "Code" = field("Country/Region Code");
                    column(CompCountryName; Name)
                    {

                    }
                }

            }
            trigger OnAfterGetRecord()
            begin
                FormatAddressFields("Purchase Header");
                Totals();
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     // layout(LayoutName)
    //     // {
    //     //     Type = Word;
    //     //    // LayoutFile = 'Cronus Report project.docx';
    //     // }
    // }
    var
        TotalIncVAT, TotalExcVAT, VATAmount : Decimal;
        VATAmount_Lbl: Label 'VAT Amount';
        TotalExcVAT_Lbl: Label 'Total GBP Excl. VAT ';
        TotalIncVAT_Lbl: Label 'Total GBP Incl. VAT ';
        DocumentTitle_Lbl: Label 'Purchase Order';
        Page_Lbl: Label 'Page';
        ShiptoAddress_Lbl: Label 'Ship to Address';
        PaymentTermsDesc_Lbl: Label 'Payment Terms';
        Buyer_Lbl: Label 'Buyer';
        Receiveby_Lbl: Label 'Receive by';
        ShipmentMethodDesc_Lbl: Label 'Shipment Method';
        PricesInclVAT_PurchHeader_Lbl: Label 'Prices Including VAT';
        CompanyVATRegistrationNo_Lbl: Label 'VAT Registration No';
        CompanyGiroNo_Lbl: Label 'Giro No.';
        VendorInvoiceNo_Lbl: Label 'Vendor Invoice No';
        VendorOrderNo_Lbl: Label 'Vendor Order No.';
        No_PurchLine_Lbl: Label 'No.';
        Desc_PurchLine_Lbl: Label 'Description';
        Qty_PurchLine_Lbl: Label 'Quantity';
        UOM_PurchLine_Lbl: Label 'Unit of Measurement';
        DirectUniCost_Lbl: Label 'Direct Unit Cost';
        VATAmtLineVAT_Lbl: Label 'VAT %';
        ItemLineAmount_Lbl: Label 'Line Amount';
        CompanyHomePage_Lbl: Label 'Company Home Page';
        CompanyPhoneNo_Lbl: Label 'Company Phone No';
        CompanyEmail_Lbl: Label 'Company Email';
        VATRegistrationNo_Lbl: Label 'VAT Registration No.';
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];

    protected var
        FormatAddr: Codeunit "Format Address";
        ResponsibilityCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";

    local procedure Totals()
    var
    //PurchaseLine: Record "Purchase Line";
    // PurchaseHeader: Record "Purchase Header";
    begin
        "Purchase Line".SetFilter("Document No.", "Purchase Header"."No.");
        TotalExcVAT := 0;
        TotalIncVAT := 0;
        VATAmount := 0;
        if "Purchase Line".FindSet() then
            repeat
                TotalExcVAT := TotalExcVAT + "Purchase Line"."Line Amount";
                VATAmount := VATAmount + (("Purchase Line"."VAT %" / 100) * "Purchase Line"."Line Amount");
            until "Purchase Line".Next() = 0;

        TotalIncVAT := TotalExcVAT + VATAmount;
    end;







    // trigger OnPreReport()
    // begin
    //     FormatAddressFields("Purchase Header");
    // end;


    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    var

    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", ResponsibilityCenter, "Company Information", CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;



}
