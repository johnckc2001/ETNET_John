pageextension 50003 "Fixed Asset Card Extension" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Responsible Employee")
        {
            field("Inventory Item No."; Rec."Inventory Item No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast("Fixed &Asset")
        {
            action(Movement)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Movement';
                Image = Line;
                RunObject = page "Item Ledger Entries";
                RunPageLink = "Item No." = field("Inventory Item No.");
            }
        }

    }
}
