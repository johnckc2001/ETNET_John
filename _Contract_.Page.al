page 50003 "Contract"
{
    Caption = 'Contract';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Contract));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("External Document No."; "External Document No.")
                {
                    Caption = 'Contract No.';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                    ToolTip = 'Specifies a Contract No.';
                }
                field("Data Line - Contract No."; "Data Line - Contract No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Data Line - Own broadband"; "Data Line - Own broadband")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        CurrPage.Update;
                    end;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        CurrPage.Update;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if LookupSellToCustomerName() then CurrPage.Update();
                    end;
                }
                group(Control114)
                {
                    ShowCaption = false;
                    Visible = ShowQuoteNo;

                    field("Quote No."; "Quote No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.';
                    }
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    Visible = false;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';

                    field("Sell-to Address"; "Sell-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the address where the customer is located.';
                    }
                    field("Sell-to Address 2"; "Sell-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Sell-to City"; "Sell-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control123)
                    {
                        ShowCaption = false;
                        Visible = IsSellToCountyVisible;

                        field("Sell-to County"; "Sell-to County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field("Sell-to Post Code"; "Sell-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the country or region of the address.';

                        trigger OnValidate()
                        begin
                            IsSellToCountyVisible := FormatAddress.UseCounty("Sell-to Country/Region Code");
                        end;
                    }
                    field("Sell-to Contact Type"; "Sell-to Contact Type")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Sell-to Contact Type';
                    }
                    field("Sell-to Contact No."; "Sell-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact person that the sales document will be sent to.';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            if GetFilter("Sell-to Contact No.") = xRec."Sell-to Contact No." then if "Sell-to Contact No." <> xRec."Sell-to Contact No." then SetRange("Sell-to Contact No.");
                        end;
                    }
                    field("Sell-to Contact"; "Sell-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Importance = Additional;
                        Editable = "Sell-to Customer No." <> '';
                        ToolTip = 'Specifies the name of the person to contact at the customer.';
                    }
                    field("Sell-to Phone No."; "Sell-to Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Phone No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the telephone number of the contact person that the sales document will be sent to.';
                    }
                    field(SellToMobilePhoneNo; SellToContact."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mobile Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the mobile telephone number of the contact person that the sales document will be sent to.';
                    }
                    field("Sell-to E-Mail"; "Sell-to E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email';
                        Importance = Additional;
                        ToolTip = 'Specifies the email address of the contact person that the sales document will be sent to.';
                    }
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Sell-to Contact 2 Type"; "Sell-to Contact 2 Type")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Sell-to Contact 2 Type';
                }
                field("Sell-to Contact 2 No."; "Sell-to Contact 2 No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sell-to Contact 2 No.';
                    ToolTip = 'Specifies the number of the contact 2';
                    Visible = false;
                }
                field("Sell-to Contact 2"; "Sell-to Contact 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sell-to Contact 2';
                    ToolTip = 'Specifies the name of the contact 2';
                }
                field("Sell-to Contact 3 Type"; "Sell-to Contact 3 Type")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Sell-to Contact 3 Type';
                }
                field("Sell-to Contact 3 No."; "Sell-to Contact 3 No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sell-to Contact 3 No.';
                    ToolTip = 'Specifies the number of the contact 3';
                    Visible = false;
                }
                field("Sell-to Contact 3"; "Sell-to Contact 3")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sell-to Contact 3';
                    ToolTip = 'Specifies the name of the contact 3';
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Estimated Installation Date"; "Estimated Installation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Actual Installation Date"; "Actual Installation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Initial Contract Period"; "Initial Contract Period")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Initial Contract Start Date"; "Initial Contract Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Initial Contract End Date"; "Initial Contract End Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Waived Contract Period"; "Waived Contract Period")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Billing Cycle"; "Billing Cycle")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Rollover Frequency"; "Rollover Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    AccessByPermission = TableData "Responsibility Center" = R;
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field(Status; Status)
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
            }
            part(ContractLines; "Contract Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = "Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';

                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency of amounts on the sales document.';

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        if "Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                        else
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = ACTION::OK then begin
                            Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            SaveInvoiceDiscountAmount;
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';

                    trigger OnValidate()
                    begin
                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        CurrPage.Update;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';

                    trigger OnValidate()
                    begin
                        UpdatePaymentService();
                    end;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';

                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                group(Control91)
                {
                    ShowCaption = false;

                    group(Control90)
                    {
                        ShowCaption = false;

                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            OptionCaption = 'Default (Sell-to Address),Alternate Shipping Address,Custom Address';
                            ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                            begin
                                OnBeforeValidateShipToOptions(Rec, ShipToOptions);
                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            Validate("Ship-to Code", '');
                                            CopySellToAddressToShipToAddress;
                                        end;
                                    ShipToOptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", "Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableView(ShipToAddress);
                                            if ShipToAddressList.RunModal = ACTION::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                OnValidateShipToOptionsOnAfterShipToAddressListGetRecord(ShipToAddress, Rec);
                                                Validate("Ship-to Code", ShipToAddress.Code);
                                                IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                            end
                                            else
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        end;
                                    ShipToOptions::"Custom Address":
                                        begin
                                            Validate("Ship-to Code", '');
                                            IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
                                        end;
                                end;
                                OnAfterValidateShippingOptions(Rec, ShipToOptions);
                            end;
                        }
                        group(Control4)
                        {
                            ShowCaption = false;
                            Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");

                            field("Ship-to Code"; "Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Code';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                                trigger OnValidate()
                                var
                                    ShipToAddress: Record "Ship-to Address";
                                begin
                                    if (xRec."Ship-to Code" <> '') and ("Ship-to Code" = '') then Error(EmptyShipToCodeErr);
                                    if "Ship-to Code" <> '' then begin
                                        ShipToAddress.Get("Sell-to Customer No.", "Ship-to Code");
                                        IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                    end
                                    else
                                        IsShipToCountyVisible := false;
                                end;
                            }
                            field("Ship-to Name"; "Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address"; "Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address 2"; "Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to City"; "Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the city of the customer on the sales document.';
                            }
                            group(Control297)
                            {
                                ShowCaption = false;
                                Visible = IsShipToCountyVisible;

                                field("Ship-to County"; "Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'County';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    QuickEntry = false;
                                    ToolTip = 'Specifies the state, province or county of the address.';
                                }
                            }
                            field("Ship-to Post Code"; "Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the postal code.';
                            }
                            field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the customer''s country/region.';

                                trigger OnValidate()
                                begin
                                    IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
                                end;
                            }
                        }
                    }
                }
                group(Control85)
                {
                    ShowCaption = false;

                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bill-to';
                        OptionCaption = 'Default (Customer),Another Customer,Custom Address';
                        ToolTip = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if BillToOptions = BillToOptions::"Default (Customer)" then begin
                                Validate("Bill-to Customer No.", "Sell-to Customer No.");
                                RecallModifyAddressNotification(GetModifyBillToCustomerAddressNotificationId);
                            end;
                            CopySellToAddressToBillToAddress;
                        end;
                    }
                    group(Control82)
                    {
                        ShowCaption = false;
                        Visible = NOT (BillToOptions = BillToOptions::"Default (Customer)");

                        field("Bill-to Name"; "Bill-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = BillToOptions = BillToOptions::"Another Customer";
                            Enabled = BillToOptions = BillToOptions::"Another Customer";
                            Importance = Promoted;
                            ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.';

                            trigger OnValidate()
                            begin
                                if GetFilter("Bill-to Customer No.") = xRec."Bill-to Customer No." then if "Bill-to Customer No." <> xRec."Bill-to Customer No." then SetRange("Bill-to Customer No.");
                                CurrPage.SaveRecord;
                                if ApplicationAreaMgmtFacade.IsFoundationEnabled then SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                                CurrPage.Update(false);
                            end;
                        }
                        field("Bill-to Address"; "Bill-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the address of the customer that you will send the invoice to.';
                        }
                        field("Bill-to Address 2"; "Bill-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field("Bill-to City"; "Bill-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the city of the customer on the sales document.';
                        }
                        group(Control130)
                        {
                            ShowCaption = false;
                            Visible = IsBillToCountyVisible;

                            field("Bill-to County"; "Bill-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                                Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the state, province or county of the address.';
                            }
                        }
                        field("Bill-to Post Code"; "Bill-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region Code';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the country or region of the address.';

                            trigger OnValidate()
                            begin
                                IsBillToCountyVisible := FormatAddress.UseCounty("Bill-to Country/Region Code");
                            end;
                        }
                        field("Bill-to Contact No."; "Bill-to Contact No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact No.';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Importance = Additional;
                            ToolTip = 'Specifies the number of the contact the invoice will be sent to.';
                            Visible = false;
                        }
                        field("Bill-to Contact"; "Bill-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR ("Bill-to Customer No." <> "Sell-to Customer No.");
                            ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.';
                        }
                        field(BillToContactPhoneNo; BillToContact."Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the telephone number of the person you should contact at the customer you are sending the invoice to.';
                        }
                        field(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Mobile Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the mobile telephone number of the person you should contact at the customer you are sending the invoice to.';
                        }
                        field(BillToContactEmail; BillToContact."E-Mail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Email';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = EMail;
                            ToolTip = 'Specifies the email address of the person you should contact at the customer you are sending the invoice to.';
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(36), "No." = FIELD("No."), "Document Type" = FIELD("Document Type");
            }
            part(Control35; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part(Control1906127307; "Sales Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = ContractLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                ApplicationArea = Basic, Suite;
                Provider = ContractLines;
                SubPageLink = "No." = FIELD("No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1907012907; "Resource Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                Provider = ContractLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";

                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    var
                        Handled: Boolean;
                    begin
                        OnBeforeStatisticsAction(Rec, Handled);
                        if not Handled then begin
                            OpenSalesOrderStatistics;
                            SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                        end
                    end;
                }
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No."), "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = "No." <> '';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Sales Header", "Document Type".AsInteger(), "No.");
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(AssemblyOrders)
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Assembly;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;
                    ToolTip = 'View ongoing assembly orders related to the sales order. ';

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 Sales';
                Visible = CRMIntegrationEnabled;

                action(CRMGoToSalesOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
                    Image = CoupledOrder;
                    ToolTip = 'View the selected sales order.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RecordId);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;

                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View related posted sales shipments.';
                }
                action(Invoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of ongoing sales invoices for the order.';
                }
                action(Movement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Movement';
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Contract No." = field("No.");
                    RunPageView = sorting("Entry No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the transfer order.';
                }
                action("Warehouse Shipment Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'View ongoing warehouse shipments for the document, in advanced warehouse configurations.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;

                action(PagePostedSalesPrepaymentInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action(PagePostedSalesPrepaymentCrMemos)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
            }
            group(History)
            {
                Caption = 'History';

                action(PageInteractionLogEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category10;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a list of interaction log entries related to this document.';

                    trigger OnAction()
                    begin
                        ShowInteractionLogEntries;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Status <> Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                group("Create Purchase Document")
                {
                    Caption = 'Create Purchase Document';
                    Image = NewPurchaseInvoice;
                    ToolTip = 'Create a new purchase document so you can buy items from a vendor.';

                    action(CreatePurchaseOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Purchase Orders';
                        Image = Document;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category8;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        ToolTip = 'Create one or more new purchase orders to buy the items that are required by this sales document, minus any quantity that is already available.';

                        trigger OnAction()
                        var
                            PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                        begin
                            PurchDocFromSalesDoc.CreatePurchaseOrder(Rec);
                        end;
                    }
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount that applies to the sales order.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(GetRecurringSalesLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Get Recurring Sales Lines';
                    Ellipsis = true;
                    Image = CustomerCode;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Insert sales document lines that you have set up for the customer as recurring. Recurring sales lines could be for a monthly replenishment order or a fixed freight expense.';

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = "No." <> '';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        CopyDocument();
                        if Get("Document Type", "No.") then;
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Prepare to create a replacement sales order in a sales return process.';

                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Send IC Sales Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    ApplicationArea = Intercompany;
                    Caption = 'Send IC Sales Order';
                    Image = IntercompanyOrder;
                    ToolTip = 'Send the sales order to the intercompany outbox or directly to the intercompany partner if automatic transaction sending is enabled.';

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;

                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.", RecordId));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTip = 'Remove any incoming document records and file attachments.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.Get("Incoming Document Entry No.") then IncomingDocument.RemoveLinkToRelatedRecord;
                            "Incoming Document Entry No." := 0;
                            Modify(true);
                        end;
                    }
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;

                action(OrderPromising)
                {
                    AccessByPermission = TableData "Order Promising Line" = R;
                    ApplicationArea = OrderPromising;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", "Document Type");
                        OrderPromisingLine.SetRange("Source ID", "No.");
                        PAGE.RunModal(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Demand Overview';
                    Image = Forecast;
                    ToolTip = 'Get an overview of demand for your items when planning sales, production, jobs, or service management and when they will be available.';

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                    begin
                        DemandOverview.SetCalculationParameter(true);
                        DemandOverview.Initialize(0D, 1, "No.", '', '');
                        DemandOverview.RunModal;
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder("No.");
                        SalesPlanForm.RunModal;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                group(Flow)
                {
                    Caption = 'Flow';
                    Image = Flow;

                    action(CreateFlow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create a Flow';
                        Image = Flow;
                        Promoted = true;
                        PromotedCategory = Category9;
                        ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
                        Visible = IsSaas;

                        trigger OnAction()
                        var
                            FlowServiceManagement: Codeunit "Flow Service Management";
                            FlowTemplateSelector: Page "Flow Template Selector";
                        begin
                            // Opens page 6400 where the user can use filtered templates to create new flows.
                            FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetSalesTemplateFilter);
                            FlowTemplateSelector.Run;
                        end;
                    }
                    action(SeeFlows)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'See my Flows';
                        Image = Flow;
                        Promoted = true;
                        PromotedCategory = Category9;
                        RunObject = Page "Flow Selector";
                        ToolTip = 'View and configure Power Automate flows that you created.';
                    }
                }
            }
            group(Action3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                        if not Find('=><') then Init;
                    end;
                }
                action("Create &Warehouse Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create &Warehouse Shipment';
                    Image = NewShipment;
                    ToolTip = 'Create a warehouse shipment to start a pick a ship process according to an advanced warehouse configuration.';

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                        if not Find('=><') then Init;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the sales document and create a new, empty one.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Sales-Post and Send", NavigateAfterPost::"Do Nothing");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                action(ProformaInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pro Forma Invoice';
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    ToolTip = 'View or print the pro forma sales invoice.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintProformaSalesInvoice(Rec);
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;

                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ToolTip = 'Preview the prepayment transactions that will results from posting the sales document as invoiced. ';

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Post the specified prepayment information. ';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Post the specified prepayment information and print the related report. ';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PreviewPrepmtInvoicePosting)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Preview Prepmt. Invoice Posting';
                        Image = ViewPostedOrder;
                        ToolTip = 'Review the different types of entries that will be created when you post the prepayment invoice.';

                        trigger OnAction()
                        begin
                            ShowPrepmtInvoicePreview;
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Create and post a credit memo for the specified prepayment information.';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Create and post a credit memo for the specified prepayment information and print the related report.';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                    action(PreviewPrepmtCrMemoPosting)
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Preview Prepmt. Cr. Memo Posting';
                        Image = ViewPostedOrder;
                        ToolTip = 'Review the different types of entries that will be created when you post the prepayment credit memo.';

                        trigger OnAction()
                        begin
                            ShowPrepmtCrMemoPreview;
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;

                action("Work Order")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Prepare to registers actual item quantities or time used in connection with the sales order. For example, the document can be used by staff who perform any kind of processing work in connection with the sales order. It can also be exported to Excel if you need to process the sales line data further.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Pick Instruction';
                    Image = Print;
                    ToolTip = 'Print a picking list that shows which items to pick and ship for the sales order. If an item is assembled to order, then the report includes rows for the assembly components that must be picked. Use this report as a pick instruction to employees in charge of picking sales items or assembly components for the sales order.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;

                action(SendEmailConfirmation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    ToolTip = 'Send a sales order confirmation by email. The attachment is sent as a .pdf.';

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                group(Action96)
                {
                    Visible = false;

                    action("Print Confirmation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Confirmation';
                        Ellipsis = true;
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = Category11;
                        ToolTip = 'Print a sales order confirmation.';
                        Visible = NOT IsOfficeHost;

                        trigger OnAction()
                        begin
                            DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                        end;
                    }
                    action(AttachAsPDF)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Attach as PDF';
                        Ellipsis = true;
                        Image = PrintAttachment;
                        Promoted = true;
                        PromotedCategory = Category11;
                        ToolTip = 'Create a PDF file and attach it to the document.';

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                        begin
                            SalesHeader := Rec;
                            SalesHeader.SetRecFilter();
                            DocPrint.PrintSalesOrderToDocumentAttachment(SalesHeader, DocPrint.GetSalesOrderPrintToAttachmentOption(Rec));
                        end;
                    }
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        SalesHeader: Record "Sales Header";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
    begin
        DynamicEditable := CurrPage.Editable;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RecordId);
        CRMIsCoupledToRecord := CRMIntegrationEnabled;
        if CRMIsCoupledToRecord then CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RecordId);
        UpdatePaymentService();
        if CallNotificationCheck then begin
            SalesHeader := Rec;
            SalesHeader.CalcFields("Amount Including VAT");
            CustCheckCrLimit.SalesHeaderCheck(SalesHeader);
            CheckItemAvailabilityInLines;
            CallNotificationCheck := false;
        end;
        StatusStyleTxt := GetStatusStyleText();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        UpdateShipToBillToGroupVisibility;
        WorkDescription := GetWorkDescription;
        if BillToContact.Get("Bill-to Contact No.") then;
        if SellToContact.Get("Sell-to Contact No.") then;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if DocNoVisible then CheckCreditMaxBeforeInsert;
        if ("Sell-to Customer No." = '') and (GetFilter("Sell-to Customer No.") <> '') then CurrPage.Update(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        xRec.Init();
        "Responsibility Center" := UserMgt.GetSalesFilter;
        if (not DocNoVisible) and ("No." = '') then SetSellToCustomerFromFilter;
        SetDefaultPaymentServices;
        UpdateShipToBillToGroupVisibility;
    end;

    trigger OnOpenPage()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;
        SetRange("Date Filter", 0D, WorkDate());
        ActivateFields();
        SetDocNoVisible();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsAvailable;
        IsSaas := EnvironmentInfo.IsSaaS;
        if ("No." <> '') and ("Sell-to Customer No." = '') then DocumentIsPosted := (not Get("Document Type", "No."));
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not DocumentIsScheduledForPosting and ShowReleaseNotification then if not InstructionMgt.ShowConfirmUnreleased then exit(false);
        if not DocumentIsPosted then exit(ConfirmCloseUnposted);
    end;

    var
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        CustomerMgt: Codeunit "Customer Mgt.";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
        [InDataSet]
        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeHost: Boolean;
        CanCancelApprovalForRecord: Boolean;
        JobQueuesUsed: Boolean;
        ShowQuoteNo: Boolean;
        DocumentIsPosted: Boolean;
        DocumentIsScheduledForPosting: Boolean;
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        CallNotificationCheck: Boolean;
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsCustomerOrContactNotEmpty: Boolean;
        WorkDescription: Text;
        [InDataSet]
        StatusStyleTxt: Text;
        IsSaas: Boolean;
        IsBillToCountyVisible: Boolean;
        IsSellToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;

    protected var
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer","Custom Address";

    local procedure ActivateFields()
    begin
        IsBillToCountyVisible := FormatAddress.UseCounty("Bill-to Country/Region Code");
        IsSellToCountyVisible := FormatAddress.UseCounty("Sell-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
    end;

    procedure PostDocument(PostingCodeunitID: Integer;
    Navigate: Option)
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        SendToPosting(PostingCodeunitID);
        DocumentIsScheduledForPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get("Document Type", "No.")) or DocumentIsScheduledForPosting;
        OnPostOnAfterSetDocumentIsPosted(SalesHeader, DocumentIsScheduledForPosting, DocumentIsPosted);
        CurrPage.Update(false);
        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then exit;
        case Navigate of
            NavigateAfterPost::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then ShowPostedConfirmationMessage;
                    if DocumentIsScheduledForPosting or DocumentIsPosted then CurrPage.Close();
                end;
            NavigateAfterPost::"New Document":
                if DocumentIsPosted then begin
                    Clear(SalesHeader);
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
                    OnPostOnBeforeSalesHeaderInsert(SalesHeader);
                    SalesHeader.Insert(true);
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.ContractLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit "Document Totals";
    begin
        CurrPage.SaveRecord;
        DocumentTotals.SalesRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.Update(false);
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.ContractLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, "No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure ShowPrepmtInvoicePreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        //SalesPostPrepaymentYesNo.Preview(Rec, 2);
    end;

    local procedure ShowPrepmtCrMemoPreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        //SalesPostPrepaymentYesNo.Preview(Rec, 3);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := "Incoming Document Entry No." <> 0;
        ShowQuoteNo := "Quote No." <> '';
        SetExtDocNoMandatoryCondition;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        IsCustomerOrContactNotEmpty := ("Sell-to Customer No." <> '') or ("Sell-to Contact No." <> '');
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderSalesHeader.Get("Document Type", "No.") then begin
            SalesInvoiceHeader.SetRange("No.", "Last Posting No.");
            if SalesInvoiceHeader.FindFirst then if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."), InstructionMgt.ShowPostedConfirmationMessageCode) then PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    protected procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    procedure UpdateShipToBillToGroupVisibility()
    begin
        CustomerMgt.CalculateShipToBillToOptions(ShipToOptions, BillToOptions, Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header";
    var Handled: Boolean)
    begin
    end;

    procedure CheckNotificationsOnce()
    begin
        CallNotificationCheck := true;
    end;

    local procedure ShowReleaseNotification(): Boolean
    var
        LocationsQuery: Query "Locations from items Sales";
    begin
        if TestStatusIsNotReleased then begin
            LocationsQuery.SetRange(Document_No, "No.");
            LocationsQuery.SetRange(Require_Pick, true);
            LocationsQuery.Open;
            if LocationsQuery.Read then exit(true);
            LocationsQuery.SetRange(Require_Pick);
            LocationsQuery.SetRange(Require_Shipment, true);
            LocationsQuery.Open;
            exit(LocationsQuery.Read);
        end;
        exit(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShippingOptions(var SalesHeader: Record "Sales Header";
    ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShipToOptions(var SalesHeader: Record "Sales Header";
    ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header";
    var IsScheduledPosting: Boolean;
    var DocumentIsPosted: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateShipToOptionsOnAfterShipToAddressListGetRecord(var ShipToAddress: Record "Ship-to Address";
    var SalesHeader: Record "Sales Header")
    begin
    end;
}
