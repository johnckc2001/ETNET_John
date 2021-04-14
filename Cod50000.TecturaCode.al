codeunit 50000 "Tectura Code"
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostInvPostBuffer', '', true, true)]
    procedure CreateItemJnlLine(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchHeader: Record "Purchase Header"; GLEntryNo: Integer; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    var
        l_recFA: Record "Fixed Asset";
        l_recItem: Record "Item";
        l_recItemJnlLine: Record "Item Journal Line";
        l_cduItemJnlPost: Codeunit "Item Jnl.-Post Line";
        l_recFASetup: Record "FA Setup";
        l_recItemJnlBatch: Record "Item Journal Batch";
        l_intLineNo: Integer;
        l_cduCreateReservEntry: Codeunit "Create Reserv. Entry";
    begin
        if InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset" then begin
            l_recFASetup.Get();
            l_recFA.Get(InvoicePostBuffer."G/L Account");
            if l_recFA."Inventory Item No." <> '' then begin
                l_recItemJnlBatch.Reset();
                l_recItemJnlBatch.SetRange("Journal Template Name", 'ITEM');
                ;
                l_recItemJnlBatch.SetRange(Name, l_recFASetup."Item Journal Batch");
                if l_recItemJnlBatch.FindSet() then begin
                    l_recItemJnlLine.Reset();
                    l_recItemJnlLine.SetRange("Journal Template Name", l_recItemJnlBatch."Journal Template Name");
                    l_recItemJnlLine.SetRange("Journal Batch Name", l_recItemJnlBatch.Name);
                    if l_recItemJnlLine.FindLast() then
                        l_intLineNo := l_recItemJnlLine."Line No." + 10000
                    else
                        l_intLineNo := 10000;

                    l_recItemJnlLine.Init();
                    l_recItemJnlLine."Journal Template Name" := l_recItemJnlBatch."Journal Template Name";
                    l_recItemJnlLine."Journal Batch Name" := l_recItemJnlBatch.Name;
                    l_recItemJnlLine.Validate("Posting Date", Today);
                    l_recItemJnlLine."Entry Type" := l_recItemJnlLine."Entry Type"::"Positive Adjmt.";
                    l_recItemJnlLine."Document No." := PurchHeader."No.";
                    l_recItemJnlLine."Line No." := l_intLineNo;
                    l_recItemJnlLine.Validate("Item No.", l_recfa."Inventory Item No.");
                    l_recItemJnlLine.Validate("Location Code", l_recFASetup."Default Location");
                    l_recItemJnlLine.Validate(Quantity, 1);
                    l_recItemJnlLine.Insert(true);

                    Clear(l_cduCreateReservEntry);
                    l_cduCreateReservEntry.CreateReservEntryFor(Database::"Item Journal Line", l_recItemJnlLine."Entry Type", l_recItemJnlLine."Journal Template Name", l_recItemJnlLine."Journal Batch Name", 0, l_recItemJnlLine."Line No.", l_recItemJnlLine."Qty. per Unit of Measure", l_recItemJnlLine.Quantity, l_recItemJnlLine."Quantity (Base)", InvoicePostBuffer."G/L Account", '');
                    l_cduCreateReservEntry.CreateEntry(l_recItemJnlLine."Item No.", l_recItemJnlLine."Variant Code", l_recItemJnlLine."Location Code", l_recItemJnlLine.Description, TODAY, TODAY, 0, 3);
                end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', true, true)]
    procedure PostInventoryItem(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean);
    var
        l_recItemJnlLine: Record "Item Journal Line";
        l_cduItemJnlPost: Codeunit "Item Jnl.-Post Line";
        l_recFASetup: Record "FA Setup";
        l_recItemJnlBatch: Record "Item Journal Batch";

    begin
        l_recFASetup.Get();
        l_recItemJnlBatch.Get('ITEM', l_recFASetup."Item Journal Batch");

        l_recItemJnlLine.Reset();
        l_recItemJnlLine.SetRange("Journal Template Name", l_recItemJnlBatch."Journal Template Name");
        l_recItemJnlLine.SetRange("Journal Batch Name", l_recItemJnlBatch.Name);
        l_recItemJnlLine.SetRange("Document No.", PurchaseHeader."No.");
        if l_recItemJnlLine.FindSet() then begin
            Clear(l_cduItemJnlPost);
            l_cduItemJnlPost.Run(l_recItemJnlLine);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    procedure UpdateILE(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    begin
        NewItemLedgEntry."Contract No." := ItemJournalLine."Contract No.";
        NewItemLedgEntry."Service Item No." := ItemJournalLine."Service Item No.";
    end;

}
