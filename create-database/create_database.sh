# !/bin/bash
sqlite3 AuctionBase.db<create.sql
sqlite3 AuctionBase.db<load.txt
