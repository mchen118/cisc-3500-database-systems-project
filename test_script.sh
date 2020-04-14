# ! bin/bash
sqlite3 AuctionBase.db<add_an_item.sql
python Command_Line_Input.py search min=9999
python Command_Line_Input.py search min=999 category=collectibles
python Command_Line_Input.py search max=0.5
python Command_Line_Input.py search max=1 category=comics
python Command_Line_Input.py search min=98 max=99
python Command_Line_Input.py search min=99 max=99 category=collectibles
python Command_Line_Input.py bid item_id=9876543210 bidder_id=ten_toes amount=30
python Command_Line_Input.py buy item_id=9876543210 bidder_id=ten_toes amount=25
sqlite3 AuctionBase.db<reverse_changes.sql