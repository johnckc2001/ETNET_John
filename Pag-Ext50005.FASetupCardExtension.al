pageextension 50005 "FA Setup Card Extension" extends "Fixed Asset Setup"
{
    layout
    {
        addafter("Automatic Insurance Posting")
        {
            field("Item Journal Batch"; Rec."Item Journal Batch")
            {
                ApplicationArea = all;
            }
            field("Default Location"; Rec."Default Location")
            {
                ApplicationArea = all;
            }

        }
    }
}
