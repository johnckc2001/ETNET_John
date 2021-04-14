pageextension 50004 "Item Reclass. Jnl Extension" extends "Item Reclass. Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Service Item No."; Rec."Service Item No.")
            {
                ApplicationArea = all;
            }
            field("Contract No."; Rec."Contract No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
